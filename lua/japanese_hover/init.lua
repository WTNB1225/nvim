local M = {}

local config = {
  ollama_url = "http://localhost:11434/api/chat",
  model = "qwen3:4b",
  width = 80,
  height = 30,
}

---LSP hoverのcontentsを文字列へ変換する
---@param contents any
---@return string
local function hover_contents_to_text(contents)
  if type(contents) == "string" then
    return contents
  end

  if type(contents) ~= "table" then
    return ""
  end

  -- MarkupContent:
  -- {
  --   kind = "markdown",
  --   value = "..."
  -- }
  if type(contents.value) == "string" then
    return contents.value
  end

  -- MarkedString:
  -- {
  --   language = "rust",
  --   value = "fn example()"
  -- }
  if type(contents.language) == "string"
      and type(contents.value) == "string"
  then
    return string.format(
      "```%s\n%s\n```",
      contents.language,
      contents.value
    )
  end

  -- MarkedString[]
  local parts = {}

  for _, item in ipairs(contents) do
    local text = hover_contents_to_text(item)

    if text ~= "" then
      table.insert(parts, text)
    end
  end

  return table.concat(parts, "\n\n")
end

---Markdownをfloating windowで表示する
---@param text string
local function show_float(text)
  local lines = vim.split(text, "\n", {
    plain = true,
    trimempty = false,
  })

  vim.lsp.util.open_floating_preview(lines, "markdown", {
    border = "rounded",
    max_width = config.width,
    max_height = config.height,
    focusable = true,
    close_events = {
      "CursorMoved",
      "CursorMovedI",
      "BufHidden",
      "InsertCharPre",
    },
  })
end

---Ollamaを使って日本語へ翻訳する
---@param text string
---@param callback fun(translated: string|nil, error_message: string|nil)
local function translate(text, callback)
  local body = vim.json.encode({
    model = config.model,
    stream = false,
    messages = {
      {
        role = "system",
        content = table.concat({
          "あなたはプログラミング文書の翻訳者です。",
          "入力されたLSPドキュメントを自然な日本語へ翻訳してください。",
          "関数名、型名、変数名、コード、Markdown構造は変更しないでください。",
          "説明を追加せず、翻訳結果だけを返してください。",
        }, "\n"),
      },
      {
        role = "user",
        content = text,
      },
    },
  })

  vim.system({
    "curl",
    "--silent",
    "--show-error",
    "--fail",
    "--request",
    "POST",
    "--header",
    "Content-Type: application/json",
    "--data-binary",
    "@-",
    config.ollama_url,
  }, {
    stdin = body,
    text = true,
  }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        callback(nil, result.stderr or "Ollamaへの接続に失敗しました")
        return
      end

      local ok, response = pcall(vim.json.decode, result.stdout)

      if not ok then
        callback(nil, "Ollamaのレスポンスを解析できませんでした")
        return
      end

      local translated = response
        and response.message
        and response.message.content

      if type(translated) ~= "string" or translated == "" then
        callback(nil, "翻訳結果が空でした")
        return
      end

      callback(translated, nil)
    end)
  end)
end

---カーソル位置のhoverを取得して日本語で表示する
function M.hover()
  local bufnr = vim.api.nvim_get_current_buf()

  local clients = vim.lsp.get_clients({
    bufnr = bufnr,
    method = "textDocument/hover",
  })

  if #clients == 0 then
    vim.notify(
      "textDocument/hoverに対応したLSPがありません",
      vim.log.levels.WARN
    )
    return
  end

  local params = vim.lsp.util.make_position_params(
    0,
    clients[1].offset_encoding
  )

  vim.notify("LSPドキュメントを翻訳しています...")

  vim.lsp.buf_request_all(
    bufnr,
    "textDocument/hover",
    params,
    function(results)
      local documents = {}

      for _, response in pairs(results) do
        if response.result and response.result.contents then
          local text =
            hover_contents_to_text(response.result.contents)

          if text ~= "" then
            table.insert(documents, text)
          end
        end
      end

      if #documents == 0 then
        vim.notify(
          "カーソル位置にLSPドキュメントがありません",
          vim.log.levels.INFO
        )
        return
      end

      local original = table.concat(documents, "\n\n---\n\n")

      translate(original, function(translated, error_message)
        if error_message then
          vim.notify(error_message, vim.log.levels.ERROR)

          -- 翻訳失敗時には元の英語を表示
          show_float(original)
          return
        end

        show_float(translated)
      end)
    end
  )
end

---設定を上書きする
---@param opts table|nil
function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})
end

return M

-- syntax highlight
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      require("nvim-treesitter").install({
        "lua",
        "vim",
        "vimdoc",
        "query",
        "bash",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "python",
		"c"
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "lua",
          "vim",
          "vimdoc",
          "query",
          "bash",
          "json",
          "yaml",
          "markdown",
          "html",
          "css",
          "javascript",
          "typescript",
          "typescriptreact",
          "javascriptreact",
          "python",
		  "c"
        },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
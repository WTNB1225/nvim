return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },

  opts = {
    current_line_blame = false,
  },

  keys = {
    {
      "]c",
      function()
        require("gitsigns").nav_hunk("next")
      end,
      desc = "次のGit変更へ移動",
    },
    {
      "[c",
      function()
        require("gitsigns").nav_hunk("prev")
      end,
      desc = "前のGit変更へ移動",
    },
    {
      "<leader>gp",
      function()
        require("gitsigns").preview_hunk()
      end,
      desc = "Git変更を確認",
    },
    {
      "<leader>gs",
      function()
        require("gitsigns").stage_hunk()
      end,
      mode = { "n", "v" },
      desc = "Git変更をステージ",
    },
    {
      "<leader>gr",
      function()
        require("gitsigns").reset_hunk()
      end,
      mode = { "n", "v" },
      desc = "Git変更を元に戻す",
    },
    {
      "<leader>gb",
      function()
        require("gitsigns").blame_line()
      end,
      desc = "Git blameを表示",
    },
  },
}
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[                                                     ]],
      [[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
      [[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
      [[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
      [[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
      [[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
      [[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      [[                                                     ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "  ファイルを探す", "<cmd>Telescope find_files<CR>"),
      dashboard.button("r", "  最近使ったファイル", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("g", "  文字列を検索", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("e", "  ファイルツリー", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("c", "  Neovimの設定", "<cmd>edit $MYVIMRC<CR>"),
      dashboard.button("q", "  終了", "<cmd>qa<CR>"),
    }

    dashboard.section.footer.val = "よいコーディングを！"
    dashboard.config.opts.noautocmd = true
    alpha.setup(dashboard.config)
  end,
}

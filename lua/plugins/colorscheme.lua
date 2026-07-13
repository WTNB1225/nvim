return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = "dragon",
      background = {
        dark = "dragon",
        light = "lotus",
      },
      transparent = false,
      dimInactive = true,
      terminalColors = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme

        return {
          CursorLine = { bg = theme.ui.bg_p2 },
          WinSeparator = { fg = theme.ui.bg_p2 },
          NvimTreeNormal = { fg = theme.ui.fg, bg = theme.ui.bg_m3 },
          NvimTreeNormalNC = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
        }
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa-dragon")
    end,
  },
}

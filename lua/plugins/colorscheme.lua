local is_transparent = true

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = is_transparent,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    keys = {
      {
        "<leader>k",
        function()
          is_transparent = not is_transparent
          local theme = require("tokyonight")
          theme.setup(
            {
              transparent = is_transparent
            }
          )
          vim.cmd("colorscheme tokyonight")
        end,
        desc = "Toggle Background"
      }
    }
  },
}

--[[
Welcome: start screen.

Looking to get weird? Check out:
https://github.com/goolord/alpha-nvim/discussions/16
]]
return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local theme = require("alpha.themes.startify")

    theme.section.header = {
      opts = { position = "left", hl = "Type" },
      type = "text",
      val = {
        [[]],
        [[█▄▀ █ █▀▀ █▄▀ █▀▀ █░░ █ █▀█]],
        [[█░█ █ █▄▄ █░█ █▀░ █▄▄ █ █▀▀]],
      },
    }

    theme.section.top_buttons.val = {
      theme.button("e", "New file (edit)", "<cmd>ene <CR>"),
      theme.button("i", "New file (insert)", "<cmd>ene <CR> <cmd>i <CR>"),
      theme.button("g", "Git (LazyGit)", "<cmd>LazyGit<cr>"),
      theme.button("l", "Lazy (Plugins)", "<cmd>Lazy<cr>"),
      theme.button("m", "Mason (Packages)", "<cmd>Mason<cr>"),
      theme.button("w", "Wiki", "<cmd>VimwikiIndex<cr>"),
    }

    theme.config.layout = {
      { type = "padding", val = 1 },
      theme.section.header,
      { type = "padding", val = 2 },
      theme.section.top_buttons,
      theme.section.mru_cwd,
      theme.section.mru,
      { type = "padding", val = 1 },
      theme.section.bottom_buttons,
      theme.section.footer,
    }

    -- dashboard, startify, theta
    require("alpha").setup(theme.config)
  end,
}

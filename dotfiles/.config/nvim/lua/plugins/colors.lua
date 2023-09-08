--[[
Colors: colorscheme, mostly/only.
]]
local M = {}

-- https://github.com/folke/tokyonight.nvim
M.tokyonight = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- tokyonight-day, tokyonight-moon, tokyonight-night, tokyonight-storm
    vim.cmd([[colorscheme tokyonight]])
  end,
}

-- https://github.com/catppuccin/nvim
M.catpuccin = {
  "catppuccin/nvim",
  config = function()
    -- latte, frappe, macchiato, mocha
    vim.cmd([[colorscheme catppuccin-macchiato]])
  end,
  lazy = false,
  name = "catppuccin",
  priority = 1000,
}

return M.tokyonight

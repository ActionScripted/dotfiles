--[[
Help: show keybindings! Press space or z, see what happens.
]]
local M = {}

M.delay = 150
M.options = {}

return {
  {
    "folke/which-key.nvim",
    config = function(_, opts)
      vim.o.timeout = true
      vim.o.timeoutlen = M.delay
      require("which-key").setup(opts)
    end,
    opts = M.options,
  },
}

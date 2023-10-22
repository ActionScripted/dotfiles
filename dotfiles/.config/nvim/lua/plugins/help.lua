--[[
Help: show keybindings! Press space or z, see what happens.
]]

local config = require("config.kickflip")

return {
  {
    "folke/which-key.nvim",
    opts = config.help.options,
  },
}

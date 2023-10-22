--[[
Notify: notifications, warnings, errors.
]]

return {
  {
    "rcarriga/nvim-notify",
    opts = {
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      -- stages = "static",
      timeout = 2400,
      top_down = false,
    },
  },
}

--[[
Dashboard: start/welcome screen.
]]

local header_kickflip = [[
█▄▀ █ █▀▀ █▄▀ █▀▀ █░░ █ █▀█
█░█ █ █▄▄ █░█ █▀░ █▄▄ █ █▀▀]]

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        col = 3,
        row = 2,
        preset = {
          keys = {
            { icon = " ", key = "i", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "e", desc = "New File", action = ":ene", hidden = true },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "m", desc = "Mason", action = ":Mason" },
            { icon = " ", key = "w", desc = "Wiki", action = ":VimwikiIndex" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          header = header_kickflip,
        },
        sections = {
          { section = "header", align = "left" },
          { icon = " ", title = "Commands", padding = 1 },
          { section = "keys", padding = 1 },
          { icon = " ", title = "MRU ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
          { section = "recent_files", cwd = true, limit = 7, padding = 1 },
          { icon = " ", title = "MRU", padding = 1 },
          { section = "recent_files", limit = 7, padding = 1 },
          { text = { "---", hl = "SnacksDashboardDir" }, align = "left" },
          function()
            local startup = Snacks.dashboard.sections.startup({})
            startup.align = "left"
            return startup
          end,
        },
      },
    },
  },
}

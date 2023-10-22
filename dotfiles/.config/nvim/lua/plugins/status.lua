--[[
Status Line: better/richer status line.

Noice is likely hiding search and other things but if you
need to hide the bottom line set cmdheight=0.
]]

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      disabled_filetypes = {
        statusline = { "alpha", "dashboard", "mason" },
        winbar = {},
      },
      globalstatus = true,
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress", "selectioncount", "searchcount" },
        lualine_z = { "location" },
      },
    },
  },
}

--[[
Status Line
]]
-- set cmdheight=0 to hide that bottom line...
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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

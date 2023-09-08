--[[
Wiki
]]
return {
  {
    "vimwiki/vimwiki",
    cmd = { "VimwikiIndex" },
    init = function()
      local config = require("config.kickflip")

      vim.g.vimwiki_list = {
        {
          ext = ".md",
          path = config.wiki.path,
          syntax = "markdown",
        },
      }
      vim.g.vimwiki_global_ext = 0
    end,
    keys = {
      { "<leader>w", "<cmd>VimwikiIndex<cr>", desc = "Wiki" },
    },
  },
}

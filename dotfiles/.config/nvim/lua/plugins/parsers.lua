--[[
Parsers: language parsers, queries, modules.
]]

local config = require("config.kickflip")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = config.parsers.ensure_installed,
      highlight = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      indent = { enable = true },
    },
  },
}

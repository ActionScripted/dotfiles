--[[
Completion: auto-complete, snippets, etc.
]]

return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  {
    "saghen/blink.cmp",
    dependencies = { "ribru17/blink-cmp-spell" },
    opts = {
      completion = {
        list = {
          selection = {
            auto_insert = true,
            preselect = false,
          },
        },
      },
      keymap = {
        -- This is "default" but enter key also confirms.
        ["<CR>"] = { "accept", "fallback" },

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },

        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      -- fuzzy = {
      --   -- (This is for/from blink-cmp-spell)
      --   sorts = {
      --     function(a, b)
      --       local sort = require("blink.cmp.fuzzy.sort")
      --       if a.source_id == "spell" and b.source_id == "spell" then
      --         return sort.label(a, b)
      --       end
      --     end,
      --     "score",
      --     "kind",
      --     "label",
      --   },
      -- },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "spell" },
        providers = {
          spell = {
            name = "Spell",
            module = "blink-cmp-spell",
            opts = {},
          },
        },
      },
    },
  },
}

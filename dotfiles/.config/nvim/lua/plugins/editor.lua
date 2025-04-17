--[[
Appearance: themes, highlights, visuals, etc.
]]
return {

  -- Smear: animate the cursor
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      cursor_color = "#7aa2f7",
      distance_stop_animating = 0.5,
      stiffness = 0.8,
      trailing_stiffness = 0.5,
    },
  },

  -- Cloak: hide sensitive information
  {
    "laytan/cloak.nvim",
    lazy = false,
    keys = {
      { "<leader>cC", "<cmd>CloakToggle<cr>", desc = "Cloak (Toggle)" },
    },
    opts = {
      cloak_character = "*",
      cloak_length = nil,
      cloak_telescope = true,
      highlight_group = "Comment",
      patterns = {
        {
          file_pattern = { ".env*", "*.env" },
          cloak_pattern = "=.+",
          replace = nil,
        },
      },
      try_all_patterns = true,
    },
  },

  -- Colorizer: color highlighter (e.g. #FF00FF)
  {
    "catgoose/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        mode = "virtualtext",
        virtualtext = "⬥",
        virtualtext_inline = "before",
        virtualtext_mode = "foreground",
      },
    },
  },

  -- Comments: TODO-style comment highlighting
  {
    "folke/todo-comments.nvim",
    opts = {
      highlight = {
        keyword = "bg", -- "wide" is great but weird with TODO(foo) style
        pattern = [[.*<(KEYWORDS)\(?.*\)?\s*:]], -- TODO and TODO(foo) styles
      },
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        FUTURE = { icon = "󰃭 ", color = "hint", alt = { "FUT", "FTR", "NXT", "UPCOMING" } },
        HACK = { icon = " ", color = "warning" },
        NOOP = { icon = "∅ ", color = "info", alt = { "NOP", "NO-OP", "SKIP" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        PERF = { icon = "󱓟 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        TEST = { icon = "󰔛 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        TODO = { icon = " ", color = "info" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      },
    },
  },

  -- hlargs: highlight argument definitions and use
  { "m-demare/hlargs.nvim", opts = {} },

  -- Snacks: all manner of mini plugins from Folke
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
      scroll = { enabled = false },
    },
  },

  -- Theme: Tokyo Night
  {
    "folke/tokyonight.nvim",
    config = function()
      -- tokyonight-day, tokyonight-moon, tokyonight-night, tokyonight-storm
      vim.cmd([[colorscheme tokyonight]])
    end,
    lazy = false,
    priority = 1000,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "echasnovski/mini.pairs",
    enabled = false,
  },

  -- Surround: add, replace, and delete surroundings (parentheses, brackets, quotes, XML tags, etc.)
  -- NOTE: add() can feel like a lot of typing but it's using text objects!
  -- NOTE: when you `gzaiw"` you're saying "add surrounding quotes to inner word (iw)"
  -- NOTE: that means you can also do `gzais"` (sentence) or `gzai)` (parentheses) and
  -- NOTE: `gzai}` (curly braces) and so on.
  -- NOTE: https://blog.carbonfive.com/vim-text-objects-the-definitive-guide/
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gza", -- Add surrounding in Normal and Visual modes
        delete = "gzd", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "gzr", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
  },
}

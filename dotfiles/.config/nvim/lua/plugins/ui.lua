--[[
UI: Experimental UI customizations.

TODO: Move/rename. "UI" is way to general.
]]

return {

  {
    "folke/flash.nvim",
    opts = {},
    keys = false, -- disables all default key mappings
  },

  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  },

  -- twilight: dim inactive code
  {
    "folke/twilight.nvim",
    keys = {
      { "<leader>uW", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    },
    opts = {
      context = 0,
      dimming = {
        alpha = 0.5,
        inactive = true,
      },
      expand = {
        -- These are a mix of Lua and Python.
        "class_definition",
        "function",
        "function_definition",
        "if_statement",
        "method",
        "method_definition",
        "table",
      },
    },
  },

  -- shade: dim inactive windows
  {
    "sunjon/shade.nvim",
    enabled = false,
    keys = {
      {
        "<leader>uS",
        function()
          require("shade").toggle()
        end,
        desc = "Toggle Shade",
      },
    },
    opts = {
      opacity_step = 1,
      overlay_opacity = 65,
    },
  },

  -- shade: dim inactive windows
  {
    "miversen33/sunglasses.nvim",
    opts = {
      filter_percent = 0.2,
      filter_type = "SHADE",
    },
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      stages = "static",
      timeout = 1200,
      top_down = false,
    },
  },

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

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    opts = {
      options = {
        always_show_bufferline = false,
        -- stylua: ignore
        close_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = require("lazyvim.config").icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        mode = "buffers",
        offsets = {
          {
            filetype = "neo-tree",
            highlight = "Directory",
            text = "Neo-tree",
            text_align = "left",
          },
        },
        persist_buffer_sort = false,
        -- stylua: ignore
        right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        separator_style = "thick",
      },
    },
  },
}

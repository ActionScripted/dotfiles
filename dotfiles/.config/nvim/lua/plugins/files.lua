--[[
Files: file management, movement
]]

return {
  -- fzf-lua: fuzzy finder
  -- TODO: do we need to disable CTRL+u like we did with telescope?
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<c-p>", "<cmd>FzfLua files<cr>", desc = "Find files" },
    },
    opts = {
      keymap = {
        fzf = {
          ["ctrl-u"] = "unix-line-discard",
        },
      },
    },
  },

  -- NeoTree: file explorer
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      default_component_configs = {
        indent = {
          with_expanders = true,
        },
      },
      filesystem = {
        commands = {
          -- Replace delete with trash.
          -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/202
          delete = function(state)
            local inputs = require("neo-tree.ui.inputs")

            local path = state.tree:get_node().path
            local msg = "Are you sure you want to trash " .. path

            inputs.confirm(msg, function(confirmed)
              if not confirmed then
                return
              end

              vim.fn.system({ "trash", vim.fn.fnameescape(path) })
              require("neo-tree.sources.manager").refresh(state.name)
            end)
          end,
          delete_visual = function(state, selected_nodes)
            local inputs = require("neo-tree.ui.inputs")

            local count = vim.tbl_count(selected_nodes)
            local msg = "Are you sure you want to trash " .. count .. " files ?"

            inputs.confirm(msg, function(confirmed)
              if not confirmed then
                return
              end
              for _, node in ipairs(selected_nodes) do
                vim.fn.system({ "trash", vim.fn.fnameescape(node.path) })
              end
              require("neo-tree.sources.manager").refresh(state.name)
            end)
          end,
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        -- Space is our default leader
        mappings = { ["<space>"] = "none" },
      },
    },
  },
}

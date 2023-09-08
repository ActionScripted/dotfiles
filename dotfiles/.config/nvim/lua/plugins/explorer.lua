--[[
File Explorer
]]
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    },
    cmd = "Neotree",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true })
        end,
        desc = "File Explorer (toggle)",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1

      -- Show explorer if editor is launched with a directory argument.
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      default_component_configs = {
        indent = {
          with_expanders = true,
        },
      },
      filesystem = {
        bind_to_cwd = true,
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
        follow_current_file = true,
        use_libuv_file_watcher = true,
      },
      window = {
        -- Space is our default leader
        mappings = { ["<space>"] = "none" },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
      --[[
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
      ]]
    end,
  },
}

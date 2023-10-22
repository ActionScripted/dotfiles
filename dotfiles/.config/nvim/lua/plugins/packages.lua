--[[
Packages: LSP servers, DAP servers, linters, formatters, etc.
---
Handles installation of packages and their dependencies without
you having to manually install them.

Helpful commands / related:
 :Mason - Manage packages
]]

local config = require("config.kickflip")

return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>m", "<cmd>Mason<cr>", desc = "Mason (packages)" } },
    opts = { ensure_installed = config.packages.ensure_installed },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)

      local mr = require("mason-registry")

      local function install_packages()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end

      if mr.refresh then
        mr.refresh(install_packages)
      else
        install_packages()
      end
    end,
  },
}

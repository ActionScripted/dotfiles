--[[
-- Servers: language servers and debug adapters.
-- ---
-- Lanuage servers and debug adapters provide autocomplete, linting, formatting, etc.
-- Lots of wiring here to connect servers to completion, packages, etc.
--
-- Helpful commands / related:
--  :LspInfo - Show LSP information
]]

return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("lazyvim.util").has("nvim-cmp")
        end,
      },
    },
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 3,
          source = "if_many",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          prefix = "icons",
        },
        severity_sort = true,
      },
      -- add any global capabilities here
      capabilities = {},
      -- Automatically format on save
      autoformat = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        bashls = {},
        cmake = {},
        html = {},
        jsonls = {},
        tsserver = {},
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        pylsp = {
          settings = {
            pylsp = {
              -- TODO: ruff all the things
              -- https://github.com/python-lsp/python-lsp-server#configuration
              configurationSources = { "flake8", "mccabe", "pycodestyle", "pyflakes", "ruff", "ruff_lsp" },
              plugins = {
                flake8 = { enabled = true },
                mccabe = { enabled = false },
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                --ruff_lsp = { enabled = false },
                --ruff = { enabled = false },
              },
            },
          },
        },
        terraformls = {},
        yamlls = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      local Util = require("lazyvim.util")
      -- setup autoformat
      require("lazyvim.plugins.lsp.format").setup(opts)
      -- setup formatting and keymaps
      Util.on_attach(function(client, buffer)
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      -- diagnostics
      for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
          or function(diagnostic)
            local icons = require("lazyvim.config").icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities(),
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available thourgh mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end
    end,
  },

  -- Formatters.
  -- null-ls wires things like black into lsp for auto-formatting, etc.
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
          "williamboman/mason.nvim",
          "jose-elias-alvarez/null-ls.nvim",
        },
        opts = { automatic_installation = true },
      },
      "mason.nvim",
    },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.diagnostics.checkmake,
          --nls.builtins.diagnostics.flake8.with({
          --  -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/848
          --  cwd = function(params)
          --    return vim.fn.fnamemodify(params.bufname, ":h")
          --  end,
          --  diagnostics_format = "#{c}: #{m}",
          --}),
          nls.builtins.diagnostics.eslint_d,
          -- TODO: ignore .env files, somehow
          nls.builtins.diagnostics.shellcheck,
          nls.builtins.formatting.beautysh.with({
            extra_args = { "--force-function-style", "fnpar", "--indent-size", "4" },
          }),
          nls.builtins.formatting.black.with({
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/848
            cwd = function(params)
              return vim.fn.fnamemodify(params.bufname, ":h")
            end,
          }),
          nls.builtins.formatting.isort.with({
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/848
            cwd = function(params)
              return vim.fn.fnamemodify(params.bufname, ":h")
            end,
          }),
          nls.builtins.formatting.prettierd,
          nls.builtins.formatting.shfmt.with({ extra_args = { "-i", "4", "-ci", "-kp" } }),
          nls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
          }),
        },
      }
    end,
  },
}

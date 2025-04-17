local M = {}

-- Packages
M.packages = {
  ensure_installed = {
    -- NOTE: (manual) checkmake
    "beautysh",
    "black",
    "djlint",
    "eslint_d", -- TODO: replace with...Biome? Something else?
    "flake8",
    "isort",
    "prettierd",
    "ruff",
    "shfmt",
    "shellcheck",
    "stylua",
    "taplo",
  },
}

-- Parsers
M.parsers = {
  ensure_installed = {
    "bash",
    "c",
    "css",
    "html",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "regex",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
}

-- Wiki
M.wiki = {
  path = vim.env.XDG_DATA_HOME .. "/wiki/",
}

return M

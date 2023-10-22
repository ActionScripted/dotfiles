local M = {}

-- Help
M.help = {
  delay = 150,
  options = {},
}

-- Packages
M.packages = {
  ensure_installed = {
    -- NOTE: (manual) checkmake
    "beautysh",
    "black",
    "djlint",
    "eslint_d",
    "flake8",
    "isort",
    "prettierd",
    "shfmt",
    "stylua",
    "taplo",
    --"ruff",
    --"ruff-lsp",
  }
}

-- Parsers
M.parsers = {
  ensure_installed = {
    "bash",
    "c",
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
  }
}

-- Wiki
M.wiki = {
  path = vim.env.XDG_DATA_HOME .. "/wiki/",
}

return M

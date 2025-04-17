--[[
lazy.nvim
---
Plugin manager and configuration:
https://github.com/folke/lazy.nvim

Based on official starter:
https://github.com/LazyVim/starter
]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Switch to community-friendly Pyright fork
-- vim.g.lazyvim_python_lsp = "basedpyright"

require("lazy").setup({
  checker = { enabled = false },
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    colorscheme = { "tokyonight", "habamax" },
    missing = true,
  },
  performance = {
    cache = { enabled = true },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
        --"netrwPlugin",
        --"tutor",
      },
      reset = true,
    },
  },
  spec = {
    -- We lean on LazyVim for complex plugins (I yield LSP and completion)
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- LazyVim extras
    { import = "lazyvim.plugins.extras.ai.copilot" },
    { import = "lazyvim.plugins.extras.ai.copilot-chat" },
    { import = "lazyvim.plugins.extras.editor.harpoon2" },
    { import = "lazyvim.plugins.extras.editor.illuminate" },
    { import = "lazyvim.plugins.extras.editor.outline" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.angular" },
    { import = "lazyvim.plugins.extras.lang.ansible" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.helm" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.omnisharp" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.lang.sql" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.terraform" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.ui.smear-cursor" },
    -- Load our modules from lua/plugins.
    { import = "plugins" },
  },
})

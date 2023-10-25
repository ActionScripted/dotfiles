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
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
      reset = true,
    },
  },
  spec = {
    -- We lean on LazyVim for complex plugins (I yield LSP and completion)
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.coding.copilot" },
    { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.docker" },
    { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.json" },
    { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.markdown" },
    { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.python" },
    { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.rust" },
    { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.terraform" },
    { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.typescript" },
    { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.yaml" },
    { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lsp.none-ls" },
    { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.ui.alpha" },
    -- Load our modules from lua/plugins.
    { import = "plugins" },
  },
})

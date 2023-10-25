-- Bindings
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "LazyVim (Plugins)" })

-- MORE BETTER indentation to un-fuck this:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua#L71
-- Fixed via https://github.com/LazyVim/LazyVim/discussions/1239
vim.keymap.set("v", "<", "<")
vim.keymap.set("v", ">", ">")

-- Bindings
vim.g.mapleader = " "

-- MORE BETTER indentation to un-fuck this:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua#L71
-- Fixed via https://github.com/LazyVim/LazyVim/discussions/1239
vim.keymap.set("v", "<", "<")
vim.keymap.set("v", ">", ">")

-- Insert the date as YYYY-MM-DD
vim.api.nvim_set_keymap(
  "i",
  "<C-D>",
  '<C-O>:lua vim.api.nvim_feedkeys(vim.fn.strftime("%F"), "n", false)<CR>',
  { noremap = true, silent = true }
)

-- Clear diagnostic (when virtual text gets weird)
vim.api.nvim_create_user_command("ClearDiagnostics", function()
  vim.diagnostic.reset(nil, 0)
end, { desc = "Clear diagnostics" })

-- Copy select to system clipboard (might suck for non-macOS)
vim.api.nvim_set_keymap("v", "<C-C>", '"+y', { noremap = true, silent = true })

-- Setup debug (shows LSPs, linters, formatters, etc.)
vim.api.nvim_create_user_command("DebugSources", function()
  require("debug.sources").show_debug_sources()
end, { desc = "Show diagnostic sources debug info" })

vim.api.nvim_create_user_command("CopyFileName", function()
  local file_name = vim.fn.expand("%:t")
  vim.fn.setreg("+", file_name)
  print("Copied file name: " .. file_name)
end, { desc = "Copy the file name to clipboard" })

vim.api.nvim_create_user_command("CopyFilePath", function()
  local file_path = vim.fn.expand("%")
  vim.fn.setreg("+", file_path)
  print("Copied relative file path: " .. file_path)
end, { desc = "Copy the file path to clipboard" })

vim.api.nvim_create_user_command("CopyFullFilePath", function()
  local full_path = vim.fn.expand("%:p")
  vim.fn.setreg("+", full_path)
  print("Copied absolute file path: " .. full_path)
end, { desc = "Copy the full file path to clipboard" })

-- Keybinding for Copy File Name
vim.keymap.set("n", "<C-S-p>", function()
  vim.cmd("CopyFileName")
end, { desc = "Copy file name to clipboard" })

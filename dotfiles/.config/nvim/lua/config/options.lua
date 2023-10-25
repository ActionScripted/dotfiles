-- Bindings
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "LazyVim (Plugins)" })

-- Behavior
vim.opt.autowrite = false
vim.opt.clipboard = ""
vim.opt.confirm = false
vim.opt.confirm = true
vim.opt.mouse = "a"
vim.opt.shortmess:append("rIs") -- "[RO]", (no) intro, (no) search
vim.opt.swapfile = false
vim.opt.undofile = true

-- Appearance
vim.opt.equalalways = false
vim.opt.list = true
vim.opt.listchars = { tab = "> ", trail = "°" }
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.relativenumber = false -- WARN: performance hit
vim.opt.report = 42
vim.opt.ruler = true
vim.opt.showmode = true
vim.opt.syntax = "on"
vim.opt.termguicolors = true

-- Editing
vim.g.autoformat = true
vim.opt.autoindent = true
vim.opt.backspace = { "eol", "start", "indent" }
vim.opt.comments:remove("s1:/*,mb:*,ex:*/") -- 1 (nosort)
vim.opt.comments:append("s:/*,mb: *,ex: */") -- 2 (nosort)
vim.opt.comments:append("fb:*") -- 3 (nosort)
vim.opt.commentstring = " # %s"
vim.opt.encoding = "UTF-8"
vim.opt.expandtab = true
vim.opt.foldlevel = 3
vim.opt.foldmethod = "indent"
vim.opt.formatoptions:remove("t")
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.textwidth = 0

-- Search
vim.opt.hls = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.isfname:remove("=")
vim.opt.matchpairs:append("<:>")
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.wildignore:append({ "*.git", "*.svn", "__pycache__", "node_modules" })
vim.opt.wildignorecase = true
vim.opt.wildmode = "list:longest,full"

-- Skeletons
local skeletons = {
  { "*.html", "html.html" },
  { "*.py", "python.py" },
  { "*.sh", "bash.sh" },
  { "Makefile", "Makefile" },
}

for i, v in ipairs(skeletons) do
  vim.api.nvim_create_autocmd("BufNewFile", {
    command = "0r ~/.config/nvim/skeletons/" .. skeletons[i][2],
    pattern = skeletons[i][1],
  })
end

-- Git
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitconfig",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 0
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
  end,
})

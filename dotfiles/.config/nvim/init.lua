--[[

KICKFLIP.NVIM

Bleeding-edge, Lua-based Neovim configuration.
"You might get hurt, but it'll look cool."

--

I didn't create any of this. This is basically LazyVim with renamed files,
closer-to-default package settings and a few personal touches.

If you're new to all of this the short of it is Lua is 100x faster than
Vimscript: https://github.com/neovim/neovim/wiki/FAQ#why-embed-lua-instead-of-x

Plugins are managed by lazy.nvim (spacebar -> l). Plugins are lazy-loaded and
defined in the lua/plugins folder as modules conforming to the lazy.nvim spec:
https://github.com/folke/lazy.nvim

Packages are managed by mason.nvim (spacebar -> m). Packages are servers, linters
and formatters that were previously installed manually via pip, npm, and more:
https://github.com/williamboman/mason.nvim

Language servers provide autocomplete, linting, formatting, and more:
https://microsoft.github.io/language-server-protocol/

Tools that don't speak LSP (e.g. black, isort) can be used as one via null-ls:
https://github.com/jose-elias-alvarez/null-ls.nvim

Debug adapters provide debugging capabilities:
https://microsoft.github.io/debug-adapter-protocol/

Tree-sitter is a parser generator tool and an incremental parsing library:
https://neovim.io/doc/user/treesitter.html

--

Author: Michael Thompson <actionscripted@gmail.com>
License:  MIT <https://opensource.org/licenses/MIT>

Requirements:
* https://github.com/folke/lazy.nvim#%EF%B8%8F-requirements
* https://github.com/nvim-treesitter/nvim-treesitter#requirements
* https://github.com/williamboman/mason.nvim#requirements
]]

-- Bootstrap lazy.vim (plugin manager)
require("config.lazy")

-- Bindings
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "LazyVim (Plugins)" })

-- Behavior
vim.opt.mouse = "a"
vim.opt.shortmess:append("rIs") -- "[RO]", (no) intro, (no) search
vim.opt.swapfile = false

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
vim.opt.autoindent = true
vim.opt.backspace = { "eol", "start", "indent" }
vim.opt.comments:remove("s1:/*,mb:*,ex:*/") -- 1 (nosort)
vim.opt.comments:append("s:/*,mb: *,ex: */") -- 2 (nosort)
vim.opt.comments:append("fb:*") -- 3 (nosort)
vim.opt.commentstring = " # %s"
vim.opt.encoding = "UTF-8"
vim.opt.expandtab = true
vim.opt.foldlevel = 2
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

-- lazy.vim (plugins)
require("lazy").setup({
  checker = { enabled = false },
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    colorscheme = { "tokyonight-storm", "catpuccin" },
  },
  performance = {
    cache = { enabled = false },
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  spec = {
    -- We lean on LazyVim for some of the more complex plugins.
    { "LazyVim/LazyVim" },
    -- Load our modules from lua/plugins.
    { import = "plugins" },
  },
})

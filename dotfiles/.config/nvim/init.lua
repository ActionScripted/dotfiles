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

require("config.lazy")

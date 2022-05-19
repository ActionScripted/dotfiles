" Author:   Michael Thompson <actionscripted@gmail.com>
" License:  MIT <https://opensource.org/licenses/MIT>
" Version:  1.8.0
"
" Setup1:   (install vim-plug)
" Setup2:   pip3 install neovim
" Setup3:   brew install ag fzy neovim npm rg tidy-html5 yamllint
" Setup4:   brew install php composer && pecl install msgpack
" Setup5:   brew install --HEAD universal-ctags/universal-ctags/universal-ctags
" Setup6:   npm install -g eslint @babel/core @babel/eslint-parser [&& eslint -init]
" Setup7:   npm install -g markdownlint-cli
"
" Help:     help [cmd]
" Install:  PlugInstall
" Upgrade:  PlugUpdate | PlugUpgrade
" Trouble:  checkhealth


" Polyglot (language packs)
let g:jsx_ext_required = 1
let g:polyglot_disabled = ['elm']
autocmd BufNewFile,BufRead *.md set indentexpr=


" Plugins (vim-plug)
call plug#begin('~/.config/nvim/plugged')
  "Plug 'edkolev/promptline.vim'
  "Plug 'edkolev/tmuxline.vim'
  "Plug 'fmoralesc/vim-pad', { 'branch': 'devel' }
  "Plug 'majutsushi/tagbar'
  "Plug 'mattn/emmet-vim'
  "Plug 'RRethy/vim-illuminate'
  "Plug 'Shougo/denite.nvim'
  Plug 'aaronbieber/vim-quicktask'
  Plug 'ap/vim-css-color'
  Plug 'cakebaker/scss-syntax.vim'
  "Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'cloudhead/neovim-fuzzy'
  Plug 'gregsexton/MatchTag'
  Plug 'iCyMind/NeoSolarized'
  Plug 'jiangmiao/auto-pairs'
  Plug 'ludovicchabant/vim-gutentags'
  "Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
  Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
  Plug 'pangloss/vim-javascript'
  "Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
  Plug 'sheerun/vim-polyglot'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'skywind3000/gutentags_plus'
  Plug 'tpope/vim-commentary'
  "Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  "Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
  Plug 'vimwiki/vimwiki'
  Plug 'w0rp/ale'
  Plug 'yko/mojo.vim'
  Plug 'zchee/deoplete-jedi'
  " Experimental
  "Plug 'integralist/vim-mypy'
  "Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
  Plug 'leafgarland/typescript-vim'
  " Intentionally last
  Plug 'ryanoasis/vim-devicons'
call plug#end()


" Appearance
"autocmd WinEnter * setlocal cursorline
"autocmd WinLeave * setlocal nocursorline
colorscheme NeoSolarized
filetype plugin indent on
set background=dark
set list
set listchars=tab:>\ ,trail:° 
set noequalalways
set norelativenumber
set number
set numberwidth=6
set report=0
set ruler
set showmode
set termguicolors
syntax enable


" Behavior
nmap <Space> <Leader>
nmap <Leader>bq :bprevious <BAR> bdelete #<CR>
nmap <Leader>h :bprevious<CR>
nmap <Leader>l :bnext<CR>
nmap <Leader>T :enew<CR>
"set hidden
set mouse+=a
set noswapfile
set shortmess+=rI


" Formatting
set autoindent
set backspace=eol,start,indent
set comments-=s1:/*,mb:*,ex:*/     " 1 (nosort)
set comments+=s:/*,mb:\ *,ex:\ */  " 2 (nosort)
set comments+=fb:*                 " 3 (nosort)
set commentstring=\ #\ %s
set encoding=UTF-8
set expandtab
set foldlevel=0
set foldmethod=indent
set formatoptions-=t
set shiftround
set shiftwidth=2
set smartindent
set tabstop=2
set textwidth=0


" Search
set hls
set ignorecase
set incsearch
set isfname-==
set matchpairs+=<:>
set showmatch
set smartcase
set wildignore+=*.git,*.svn,__pycache__,node_modules,Icon
set wildignorecase
set wildmode=list:longest,full


" Skeletons
au BufNewFile *--call.md 0r ~/.config/nvim/skeletons/note--meeting.md
au BufNewFile *--issue.md 0r ~/.config/nvim/skeletons/note--issue.md
au BufNewFile *--meeting.md 0r ~/.config/nvim/skeletons/note--meeting.md
au BufNewFile *--process.md 0r ~/.config/nvim/skeletons/note--process.md
au BufNewFile *--quote.md 0r ~/.config/nvim/skeletons/note--scope.md
au BufNewFile *--research.md 0r ~/.config/nvim/skeletons/note--research.md
au BufNewFile *--scope.md 0r ~/.config/nvim/skeletons/note--scope.md
au BufNewFile *.html 0r ~/.config/nvim/skeletons/html.html
au BufNewFile *.py 0r ~/.config/nvim/skeletons/python.py
au BufNewFile *.sh 0r ~/.config/nvim/skeletons/bash.sh
au BufNewFile Makefile 0r ~/.config/nvim/skeletons/Makefile


" Airline (status line)
let g:airline#extensions#ale#enabled = 2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1


" ALE (linter)
let g:ale_fixers = {
\   'css': ['prettier'],
\   'javascript': ['eslint', 'prettier'],
\   'javascript.jsx': ['eslint', 'prettier'],
\   'json': ['prettier'],
\   'typescript': ['eslint', 'prettier'],
\   'typescriptreact': ['eslint', 'prettier'],
\}
"let g:ale_javascript_eslint_options = '-c ~/.config/eslint/eslintrc.js --resolve-plugins-relative-to=$(npm prefix -g)/lib/node_modules'
let g:ale_lint_on_enter = 1
"let g:ale_linters = {'javascript': ['eslint'],}
let g:ale_markdown_markdownlint_options = '-c ~/.config/markdownlint/config.json'
let g:ale_perl_perlcritic_options = '-1'
let g:ale_perl_perlcritic_showrules = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'


" Auto Pairs (auto-closing parens, et al.)
let g:AutoPairsFlyMode = 0
let g:AutoPairsMultilineClose = 0

" CHADTree (NERDTree)
nnoremap <C-n> :CHADopen<CR>
let g:chadtree_settings = {
    \ "ignore.name_exact": [
        \ '.DS_Store',
        \ '.git',
        \ '.idea',
        \ '__pycache__',
        \ 'Icon',
        \ 'node_modules',
    \ ],
    \ "view.sort_by": ["is_folder", "file_name", "ext", ],
    \ "view.window_options": {
        \ "cursorline": v:true,
        \ "foldenable": v:false,
        \ "number": v:false,
        \ "relativenumber": v:false,
        \ "signcolumn": "no",
        \ "winfixwidth": v:true,
        \ "wrap": v:false,
    \ },
\ }


" Deoplete (completion system)
" (pip3 install neovim)
let g:deoplete#enable_at_startup = 1
let g:python_host_prog = $HOME.'/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME.'/.pyenv/versions/neovim3/bin/python'
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Fuzzy (file search)
" (brew install fzy rg)
nnoremap <C-p> :FuzzyOpen<CR>


" Grepper (content search)
" (brew install ag)
nnoremap <C-g> :Grepper -tool ag<CR>


" Gutentags
let g:gutentags_cache_dir = '~/.cache/gutentags'
let g:gutentags_file_list_command = 'rg --files'


" Highlights
augroup vimrc_todo
    au Syntax * syn match myTodo /\v<(FIXME|OPTIMIZE|NOTE|TODO|XXX)/
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link myTodo Todo


" Illuminate (same-word highlights)
let g:Illuminate_ftblacklist = ['nerdtree']


" Javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1


" NERDTree (file explorer)
let g:NERDTreeIgnore = ['__pycache__', '.DS_Store', '.git', 'node_modules', 'Icon']
let g:NERDTreeMinimalUI = 1
"nnoremap <C-n> :NERDTreeToggle<CR>


" NERDTree Git
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }


" Perl
autocmd FileType perl set ts=4 | set sw=4


" PHPCD (PHP completion)
" (brew install composer && pecl install msgpack)
" Errors? `cd ~/.config/nvim/plugged/phpcd.vim && composer update`
call deoplete#custom#option('ignore_sources', {'php': ['omni']})
let g:phpcd_php_cli_executable = '/usr/local/bin/php'


" Promptline (lightweight powerline clone)
"let g:promptline_theme = 'airline_insert'
"let g:promptline_preset = {
"  \'a'    : [ '\H', ],
"  \'b'    : [ promptline#slices#user(),  ],
"  \'c'    : [ promptline#slices#vcs_branch(), '\w', 'NEWLINEHERE \\$'],
"  \'warn' : [ promptline#slices#last_exit_code() ]
"  \}


" Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_case_insensitive = 1
let g:tagbar_show_visibility = 0
let g:tagbar_singleclick = 1


" vim-pad
let g:pad#dir = '~/.config/nvim/vim-pad/'


" Vimwiki
" autocmd FileType vimwiki set syntax=markdown
let g:vimwiki_global_ext=0
let g:vimwiki_list = [{
  \'ext': '.md',
  \'path': '~/.config/nvim/wiki/',
  \'syntax': 'markdown',
\}]

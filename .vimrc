syntax enable 

"-------------General Settings--------------"
set backspace=indent,eol,start		"Make backspace behave like every other editor.
let mapleader = ',' 				"The default leader is \, but a comma is much better.
set number							"Let's activate line numbers.

set autoread						"When file is changed outside Vim autoload it

"Swaps and shit"
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

"Tabs at 4"
set autoindent noexpandtab tabstop=4 shiftwidth=4

"-------------Visuals--------------"
colorscheme space_vim_theme
set guifont=IBMPlexMono-Medium:h16
set linespace=10						"Macvim-specific line-height.
set macligatures

set guioptions-=e						"We don't want gui tabs"
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

set list
set listchars=tab:→\ 
:hi SpecialKey ctermfg=grey guifg=grey28

"Get rid of split dash lines
hi vertsplit guifg=bg

"-------------Search--------------"
set hlsearch
set incsearch

"-------------Split Management--------------"

set splitbelow
set splitright
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

"-------------Mappings--------------"

nmap <C-P> :Files<cr>
nmap <D-p> :Files<cr>

"Make it easy to edit the Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>

"Cmd + 1 to toggle NERDTree
nmap <D-1> :NERDTreeToggle<cr>

"Exit insert mode
inoremap ii <ESC>

"-------------Auto-Commands--------------"

"Automatically source the Vimrc file on save.
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

"-------------Plugins configuration--------------"

call plug#begin('~/.vim/plugged')

"File management
Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdtree'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'skwp/greplace.vim'

"Misc
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'

"Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mattn/emmet-vim'

"Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"LISP
Plug 'kovisoft/slimv'
Plug 'eraserhd/parinfer-rust', {'do':
        \  'cargo build --release'}

call plug#end()
filetype plugin indent on    " required

"--------------Plugin Configuration---------------"

"Exclude files in FZF from .gitignore"
let $FZF_DEFAULT_COMMAND = 'fd --type f'

"
"Sync NERDTree with currently opened file"
"

" wip

"Increase FZF window
let g:fzf_layout = { 'up': '~100%' }


"Use ag (the_silver_searcher) with ack.vim
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif

"Use ag in greplace
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

"
"Lightline plugin
"
set laststatus=2
set noshowmode
let $TERM="xterm-256color"
if !has('gui_running')
	set t_Co=256
endif

let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'fugitive#head'
	\ },
	\ }

"NERDCommenter keymappings
nmap <D-/>   <Plug>NERDCommenterToggle

"Go plugin
let g:go_auto_sameids = 1
autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_fmt_command = "goimports"


"Emmet
autocmd FileType html,css imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

"Slimv
"let g:slimv_swank_cmd = "!ros -e '(ql:quickload :swank) (swank:create-server)' wait &"
"let g:slimv_lisp = 'ros run'
"let g:slimv_impl = 'sbcl'

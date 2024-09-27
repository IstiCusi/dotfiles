
"""set lines=999 columns=999

" ------- Settings for Vundle ------------------------------------------------

" This is needed in case of more modern vim to avoid strange
" characters to appier on the screen. See <<help modifyOtherKeys
let &t_TI = ""
let &t_TE = ""

set nocompatible
set modeline
set nowrap
filetype off
set shell=zsh
set rtp+=~/.vim/bundle/Vundle.vim

" ------- Installed packages -------------------------------------------------
call vundle#begin()

"Plugin 'godlygeek/csapprox'    "color scheme  for vim
Plugin 'nightsense/simplifysimplify'    "color scheme  for vim
Plugin 'flazzi/vim-colorschemes'         "color schemes for vim
Plugin 'mattolenik/vim-gnometerminal-cursor' "ONLY NECESSARY FOR OLD GNOME TERMINAL
Plugin 'davidhalter/jedi-vim'		"Jedi 		  - Python completion
Plugin 'VundleVim/Vundle.vim'		"Vundle		  - installer package
Plugin 'vim-scripts/github-theme'	"GitHub Colors	  - Theme from Github
Plugin 'gioele/vim-autoswap'		"Autoswap	  - Solve autoswap problem
Plugin 'tpope/vim-sensible'		"Sensible	  - Common settings
Plugin 'vim-airline/vim-airline'	"Airline	  - better status line
Plugin 'vim-airline/vim-airline-themes' "Airline	  - Various themes:
Plugin 'alx741/vinfo'			"VInfo		  - read the linux info inside vim

Plugin 'ctrlpvim/ctrlp.vim'		"Ctrl-P		  - Context Browser
Plugin 'scrooloose/nerdtree'		"Nerdtree	  - File browser
Plugin 'nathanaelkane/vim-indent-guides' "Intentation 	  - beautiful intentation
Plugin 'Raimondi/delimitMate'		"DelimiteMate	  - Autocloses braces
Plugin 'vim-scripts/paredit.vim'	"Paredit Mode	  - Very complex but useful scheme editing
Plugin 'kien/rainbow_parentheses.vim'    "Rainbow braces  - very nice plugin for better scheme programming
Plugin 'tpope/vim-surround'		"Vim Surround	  - cs<From><To> change surrounding
Plugin 'tpope/vim-abolish'		"Vim Abolish	  - Change CamelCase to Snakecase etc
Plugin 'rust-lang/rust.vim'		"Rust 		  - Rust configuration
Plugin 'mattn/webapi-vim'		"Webapi		  - Needed for Rust functionality
Plugin 'SirVer/ultisnips'		"Ultisnippets	  - Snippets (better than SnipMate)
Plugin 'honza/vim-snippets'		"Vimsnippets	  - Snippets for different languages
Plugin 'Valloric/YouCompleteMe'		"YouCompleteMe	  - code completion
Plugin 'jwilm/racerd'			"RacerD           - I needed to add this for YouCompleteMe
Plugin 'KabbAmine/zeavim.vim'		"Zeal plugin      - Allows to open the zeal API browser
Plugin 'gryf/kickass-syntax-vim'	"Kickass asm      - C64 kickass plugin

Plugin 'majutsushi/tagbar'		"Tagbar		  - Browse the C++/C tags
Plugin 'scrooloose/syntastic'		"Syntastic	  - Syntax checking
Plugin 'scrooloose/nerdcommenter'	"Nerdcommenter	  - Allows to comment for several languages
Plugin 'pksunkara/vim-dasm'		"Dasm Assembler   - Syntax highlighting
Plugin 'tpope/vim-fugitive'		"Fugitive	  - Git tools for vim
Plugin 'wikitopian/hardmode'		"Hardmode	  - Switch to hard learning mode
Plugin 'godlygeek/tabular'		"Tabular	  - Tabularizes selection with Tabularize
Plugin 'nixon/vim-vmath'		"Vmath		  - Allows to do simple mathematics
Plugin 'sickill/vim-pasta'		"Vim-Pasta	  - Pasts correct indentation
Plugin 'bronson/vim-trailing-whitespace' "RemoveTrailing  - Removes trailing spaces after lines
Plugin 'easymotion/vim-easymotion'	"Easy motion	  - Very nice easy motion while search e.g ,,w
Plugin 'KevinGoodsell/vim-csexact'	"exact color scheme - adjusts to correct terminal colors
Plugin 'tpope/vim-fireplace'            "clojure plugin   - connects to repl
Plugin 'qpkorr/vim-renamer'		"Renamer	  - Rename a list of files
Plugin 'joonty/vim-do'			"Vim-Do	          - Run shell jobs as separate thread
Plugin 'vimwiki/vimwiki'		"vim wiki 	  - keep local wiki repo
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'


"Plugin 'terryma/vim-multiple-cursors'	"MultiCur	  - ctrl-n,p, x multiple cursors
"Plugin 'Yggdroot/indentLine'		"IndentLine	  - Shows thin vertical line by indention
"Plugin 'mg979/vim-visual-multi'		"visual multi cursor mode
"Plugin 'wfxr/minimap.vim'
"Plugin 'inkarkat/vim-mark'		"vim mark	  - add multiple high lights to words (leader m)


call vundle#end()



"------- General settings ----------------------------------------------------

set hidden

inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

set softtabstop=4              " see :h 'softtabstop'
set shiftwidth=4

autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
set makeprg=clear\ &&\ make

runtime! ftplugin/man.vim
autocmd BufRead,BufNewFile *.porth set filetype=porth

let mapleader = " "
nmap <leader>ne :NERDTree<cr>

set listchars=tab:▸\ ,eol:¬

hi MatchParen cterm=bold ctermbg=none ctermfg=yellow
set cursorline
"set background=dark
set history=10000
set autoread
set backspace=indent,eol,start
set fileencodings=ucs-bom,utf-8,default,latin1
set termencoding=utf-8
set helplang=en
set mouse=a
set printoptions=paper:a4
set ruler
set relativenumber
set number
filetype plugin indent on
syntax on

" This remaps do not work, but should. Reasoned by send ctrl-H in this
" terminal

" imap <C-BS> <C-W>
" noremap! <C-BS> <C-w>
" noremap! <C-h> <C-w>

let g:vimwiki_ext2syntax = {} " Only files in the vimwiki folder are interpreted as such
"let g:vimwiki_list = [{'path': '~/Development/vimwiki/', 'syntax': 'markdown'}]
let g:vimwiki_list = [{'path': '~/Development/vimwiki/'}]

let $PYTHON_ANA = '/home/phonon/Development/anaconda3/bin/python'

let g:minimap_width = 10
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1

" swap words and relations -- very useful

:nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
:nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>:nohlsearch<CR>

:nnoremap <leader>gz :!zeal "<cword>"&<CR><CR>


" ------------------------------ Key Remapping ------------------------------


nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>


"inoremap <esc> <nop> --- ATTENSION: Interferes with cursor, get strange char than



nnoremap ; :
inoremap jj <Esc>`^
"inoremap ,,, <ESC>A;<Esc>o
inoremap `` ","
inoremap kk <CR><Esc>k$a
map <S-Insert> <MiddleMouse>

:iabbrev @@m StephanStrauss@gmx.ch
:iabbrev @@s Dr.techn. DI Stephan Strauss (StephanStrauss@gmx.ch)
:iabbrev @@a \<CR>Stephan Strauss \<CR>Segantinistrasse 15 \<CR>8049 Zurich \<CR>Switzerland

"nnoremap <C-n> :bnext
"nnoremap <C-p> :bprevious

fun! MyHardMode()

	nnoremap <buffer> <Left> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
	nnoremap <buffer> <Right> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
	nnoremap <buffer> <Up> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
	nnoremap <buffer> <Down> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>

	inoremap <buffer> <Left> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
	inoremap <buffer> <Right> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
	inoremap <buffer> <Up> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
	inoremap <buffer> <Down> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>

	vnoremap <buffer> <Left> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
	vnoremap <buffer> <Right> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
	vnoremap <buffer> <Up> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>
	vnoremap <buffer> <Down> <Esc>:call HardModeEcho(g:HardMode_hardmodeMsg)<CR>

endfun

fun! MyEasyMode()

	silent! nunmap <buffer> <Left>
	silent! nunmap <buffer> <Right>
	silent! nunmap <buffer> <Up>
	silent! nunmap <buffer> <Down>
	silent! nunmap <buffer> <PageUp>
	silent! nunmap <buffer> <PageDown>

	silent! iunmap <buffer> <Left>
	silent! iunmap <buffer> <Right>
	silent! iunmap <buffer> <Up>
	silent! iunmap <buffer> <Down>
	silent! iunmap <buffer> <PageUp>
	silent! iunmap <buffer> <PageDown>

	silent! vunmap <buffer> <Left>
	silent! vunmap <buffer> <Right>
	silent! vunmap <buffer> <Up>
	silent! vunmap <buffer> <Down>
	silent! vunmap <buffer> <PageUp>
	silent! vunmap <buffer> <PageDown>

endfun

call MyHardMode()

" --------  Airline Plugin ---------------------------------------------------
let g:airline#extensions#tabline#enabled = 1 "Smart Tab line

" ------------ Tagbar --------------------------------------------------------
nmap <F8> :TagbarToggle<CR>

" -------- Syntastic ---------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"---------- Multiple Cursors -------------------------------------------------
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" -------- Math mode ---------------------------------------------------------

" They use a recursive definition -- this could be dangerous

vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap	     ++  vip++

" -------- Indentline  mode ---------------------------------------------------
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#A4E57E'
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)

" -------- YouCompeteMe, ultisnippets and Java eclim --------------------------

"let g:EclimCompletionMethod = 'omnifunc'
"filetype plugin indent on

let g:UltiSnipsSnippetDirectories=["UltiSnips", "myUltiSnips", "/home/phonon/Development/management/snippets"]


let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0

function! ExpandSnippetOrCarriageReturn()
	let snippet = UltiSnips#ExpandSnippetOrJump()
	if g:ulti_expand_or_jump_res > 0
		return snippet
	else
		return "\<CR>"
	endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

nnoremap <leader>gd :YcmCompleter GoTo<CR>

let g:jedi#popup_on_dot = 0
let g:jedi#environment_path = "/home/phonon/Development/anaconda3"

" ------ Rainbow parentheses ------------------------------------------------
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"-------Python settings ------------------------------------------------------

let g:ycm_python_binary_path = '/home/phonon/Development/anaconda3/bin/python3'
let $VIRTUAL_ENV = $CONDA_PREFIX

"------ Rust Settings --------------------------------------------------------

let g:ycm_rust_src_path = '/home/phonon/Development/lang/rust-src/rustc-1.9.0/src'
let g:racer_cmd="/home/phonon/.cargo/bin/racer"
let $RUST_SRC_PATH="/home/phonon/Development/lang/rust-src/rustc-1.9.0/src"
set omnifunc=syntaxcomplete#Complete

augroup rusty_g
	autocmd!
	autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
	autocmd BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" <bar> redraw!
augroup END

"------- Color scheme choice for normal vim ----------------------------------
let g:impact_transbg=1
colorscheme desert
let g:airline_theme='badwolf'

function! Header(width, word, char )
    let a:inserted_word = ' ' . a:word . ' '
    let a:word_width = strlen(a:inserted_word)
    let a:length_before = (a:width - a:word_width) / 2
    let a:hashes_before = repeat(a:char, a:length_before)
    let a:hashes_after = repeat(a:char, a:width - (a:word_width + a:length_before))
    let a:hash_line = repeat(a:char, a:width)
    let a:word_line = a:hashes_before . a:inserted_word . a:hashes_after

    :put =a:hash_line
    :put =a:word_line
    :put =a:hash_line
endfunction


"--------------------------------------------------------------------------------
"-------------------------------- Amiga Headers ---------------------------------
"--------------------------------------------------------------------------------


"set path+=~/Development/lang/amiga_sdk/NDK_3.9/Include/include_h/

"function! ChangeToAmigaCHeaders
	"let g:path+='~/Development/lang/amiga_sdk/NDK_3.9/Include/include_h/'
"endfunction

"function! ChangeToLinuxCHeaders
	"let g:path = g:standardpath
"endfunction

function! Today()
   put =strftime(\"%c\")
endfunction


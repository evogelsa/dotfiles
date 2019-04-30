" Section: Environment settings

set nocompatible              " be iMproved, required
filetype plugin on            " supposed to be off, set to this for markdown
set tabstop=3
set shiftwidth=3
set expandtab
set colorcolumn=81
set relativenumber
set number
set autoindent
set splitright
set splitbelow
" include fuzzy finder and vundle in run time path
set rtp+=~/.fzf
set rtp+=~/.vim/bundle/Vundle.vim

" Section: Plugins

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'tomtom/tcomment_vim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'sheerun/vim-polyglot'
Plugin 'joshdick/onedark.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'easymotion/vim-easymotion'
Plugin 'Yggdroot/indentLine'
Plugin 'christoomey/vim-system-copy'
Plugin 'suan/vim-instant-markdown'
Plugin 'vim-syntastic/syntastic'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'sickill/vim-pasta'
Plugin 'edkolev/tmuxline.vim'
call vundle#end()

" Section: Linter configuration

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 3
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_c_compiler_options = "-Wall -Wpedantic -ansi -g -c"
let g:syntastic_c_include_dirs = ["includes", "headers"]
let g:syntastic_python_checkers = ['python']

" Section: Lightline and tmux powerline

set laststatus=2
let g:instant_markdown_autostart = 0 " :InstantMarkdownPreview
let g:lightline = {}
let g:lightline.component_type = {
   \ 'linter_checking': 'left',
   \ 'linter_warnings': 'warning',
   \ 'linter_errors': 'error',
   \ 'linter_ok': 'left',
   \ }
let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }
" tmux powerline
let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = {
   \'a'     : '#S',
   \'b'     : '#W',
   \'c'     : '#H',
   \'win'   : '#I #W',
   \'cwin'  : '#I #W',
   \'x'     : '%R',
   \'y'     : '%A',
   \'z'     : '%D'}
" end lightline config

" Section: Vim Markdown

let g:vim_markdown_folding_disabled = 1

" Section: Key mappings

" add alt key support <M- > in normal mode
for i in range(65,90) + range(97,122)
  let c = nr2char(i)
  exec "map \e".c." <M-".c.">"
endfor
" Remap leader key to comma
let mapleader = ","
" Tab flow uses meta + direction
imap jj <ESC>
map <M-j> :tabp<cr>
map <M-k> :tabn<cr>
map <M-h> :tabfirst<cr>
map <M-l> :tablast<cr>
map <M-p> :FZF<cr>
" Ctrl + direction to change panes
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
" Bind search keys to work with easy motion
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
" Nerd tree map
map <C-b> :NERDTreeToggle<CR>
" Auto close brackets and delims
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>
" Remap C-a to C-q to not conflict with tmux
inoremap <C-a> <C-q>

" Section: Color scheme

"color scheme
syntax on
set t_Co=256
set background=dark
colorscheme PaperColor
"let g:lightline = {
"   \ 'colorscheme': 'one',
"   \ }
set noshowmode
"end colorscheme

" Section: Functions

function ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
 return "\<Right>"
 else
 return a:char
 endif
endf

function CloseBracket()
 if match(getline(line('.') + 1), '\s*}') < 0
 return "\<CR>}"
 else
 return "\<Esc>j0f}a"
 endif
endf

function QuoteDelim(char)
 let line = getline('.')
 let col = col('.')
 if line[col - 2] == "\\"
 "Inserting a quoted quotation mark into the string
 return a:char
 elseif line[col - 1] == a:char
 "Escaping out of the string
 return "\<Right>"
 else
 "Starting a string
 return a:char.a:char."\<Esc>i"
 endif
endf

"auto clsoe vim if nerdtree is only plugin left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Zoom / Restore window.
function! s:ZoomToggle() abort
   if exists('t:zoomed') && t:zoomed
      execute t:zoom_winrestcmd
      let t:zoomed = 0
   else
      let t:zoom_winrestcmd = winrestcmd()
      resize
      vertical resize
      let t:zoomed = 1
   endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <leader>z :ZoomToggle<CR>

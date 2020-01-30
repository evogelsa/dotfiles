" Section: Environment settings

set nocompatible              " be iMproved, required
filetype plugin on
set tabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=81
set number
set autoindent
set splitright
set splitbelow
set formatoptions=tqcr
set conceallevel=0
set signcolumn=yes
set redrawtime=10000
" include fuzzy finder and vundle in run time path
"set rtp+=~/.fzf
set rtp+=~/.vim/bundle/Vundle.vim

" Section: Plugins

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-endwise'
Plugin 'vim-airline/vim-airline'
Plugin 'godlygeek/tabular'
Plugin 'tomtom/tcomment_vim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'sheerun/vim-polyglot'
Plugin 'joshdick/onedark.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'easymotion/vim-easymotion'
Plugin 'Yggdroot/indentLine'
Plugin 'christoomey/vim-system-copy'
Plugin 'vim-syntastic/syntastic'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'sickill/vim-pasta'
Plugin 'edkolev/tmuxline.vim'
Plugin 'xolox/vim-misc'
Plugin 'craigemery/vim-autotag'
" Plugin 'xolox/vim-easytags'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'fatih/vim-go'
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
let g:syntastic_c_compiler_options = "-Wall -Wpedantic -g -c"
let g:syntastic_c_include_dirs = ["includes", "headers"]
let g:syntastic_python_checkers = ['python']

" Section: youcompleteme

let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1

" Section: Airline and tmux powerline

set laststatus=2
" airline supposedly help with slowdowns
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=250
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
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
" make vim table mode plugin use | for md compatibility
let g:table_mode_corner = '|'

" Section: LaTeX preview

let g:livepreview_cursorhold_recompile = 0

" Section: Vim Easytags

let g:easytags_async = 1
let g:easytags_file = '~/.vim/tags'
set tags=./.tags;
let g:easytags_on_cursorhold = 0
let g:easytags_dynamic_file = 1
let g:easytags_auto_highlight = 0
let g:easytags_autorecurse = 1
let g:ycm_collect_identifiers_from_tags_files=0

" Section: Vim autotag

let g:autotagTagsFile="./.tags"

" Section: indent line

let g:indentLine_fileTypeExclude = ['markdown']

" Section: vim-go

let g:go_snippet_engine = ""
let g:go_template_autocreate = 0
let g:go_code_completion_enabled = 0


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
" inoremap ( ()<Esc>i
" inoremap [ []<Esc>i
" inoremap { {<CR>}<up><Esc>A
"-- AUTOCLOSE --
"autoclose and position cursor to write text inside
inoremap ' ''<left>
inoremap ` ``<left>
inoremap " ""<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
"autoclose with ; and position cursor to write text inside
inoremap '; '';<left><left>
inoremap `; ``;<left><left>
inoremap "; "";<left><left>
inoremap (; ();<left><left>
inoremap [; [];<left><left>
inoremap {; {};<left><left>
"autoclose with , and position cursor to write text inside
inoremap ', '',<left><left>
inoremap `, ``,<left><left>
inoremap ", "",<left><left>
inoremap (, (),<left><left>
inoremap [, [],<left><left>
inoremap {, {},<left><left>
"autoclose and position cursor after
inoremap '<tab> ''
inoremap `<tab> ``
inoremap "<tab> ""
inoremap (<tab> ()
inoremap [<tab> []
inoremap {<tab> {}
"autoclose with ; and position cursor after
inoremap ';<tab> '';
inoremap `;<tab> ``;
inoremap ";<tab> "";
inoremap (;<tab> ();
inoremap [;<tab> [];
inoremap {;<tab> {};
"autoclose with , and position cursor after
inoremap ',<tab> '',
inoremap `,<tab> ``,
inoremap ",<tab> "",
inoremap (,<tab> (),
inoremap [,<tab> [],
inoremap {,<tab> {},
"autoclose 2 lines below and position cursor in the middle
inoremap '<CR> '<CR>'<ESC>O<tab>
inoremap `<CR> `<CR>`<ESC>O<tab>
inoremap "<CR> "<CR>"<ESC>O<tab>
inoremap (<CR> (<CR>)<ESC>O<tab>
inoremap [<CR> [<CR>]<ESC>O<tab>
inoremap {<CR> {<CR>}<ESC>O<tab>
"autoclose 2 lines below adding ; and position cursor in the middle
inoremap ';<CR> '<CR>';<ESC>O<tab>
inoremap `;<CR> `<CR>`;<ESC>O<tab>
inoremap ";<CR> "<CR>";<ESC>O<tab>
inoremap (;<CR> (<CR>);<ESC>O<tab>
inoremap [;<CR> [<CR>];<ESC>O<tab>
inoremap {;<CR> {<CR>};<ESC>O<tab>
"autoclose 2 lines below adding , and position cursor in the middle
inoremap ',<CR> '<CR>',<ESC>O<tab>
inoremap `,<CR> `<CR>`,<ESC>O<tab>
inoremap ",<CR> "<CR>",<ESC>O<tab>
inoremap (,<CR> (<CR>),<ESC>O<tab>
inoremap [,<CR> [<CR>],<ESC>O<tab>
inoremap {,<CR> {<CR>},<ESC>O<tab>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>
" Remap C-a to C-q to not conflict with tmux
inoremap <C-a> <C-q>
" :set ts=2 noet | retab! | set et ts=4 | retab
nnoremap <silent> <F6> :set ts=2 noet <Bar> retab! <Bar> set et ts=4 <Bar> retab <CR>
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>


" Section: Color scheme

"color scheme
set t_Co=256
set background=dark
colorscheme PaperColor
syntax enable
syntax sync fromstart
hi Normal guibg=NONE ctermbg=NONE
hi NonText ctermbg=NONE
highlight ColorColumn ctermbg=7
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

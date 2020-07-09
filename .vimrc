" Section: Environment settings


set nocompatible              " be iMproved, required
filetype plugin on
set tabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=81
set number
set relativenumber
set autoindent
set splitright
set splitbelow
set formatoptions=tqcr
set conceallevel=0
set redrawtime=10000
set laststatus=2


" Section: Key mappings
"

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


set t_Co=256
set background=dark
syntax enable
syntax sync fromstart
hi Normal guibg=NONE ctermbg=NONE
hi NonText ctermbg=NONE
highlight ColorColumn ctermbg=7
set noshowmode


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

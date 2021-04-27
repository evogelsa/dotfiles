" Section: Environment settings


set nocompatible              " be iMproved, required
filetype plugin on

set tabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=81
highlight ColorColumn ctermbg=238
set number
set relativenumber
set autoindent
set splitright
set splitbelow
set formatoptions=tqcr
set conceallevel=0
set signcolumn=yes
set redrawtime=10000
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set rtp+=~/.config/nvim/bundle/Vundle.vim
let mapleader = ","


" Section: Plugins


call vundle#begin('$HOME/.config/nvim/bundle')
Plugin 'VundleVim/Vundle.vim'

" utility
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'preservim/nerdcommenter'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdtree'
Plugin 'easymotion/vim-easymotion'
Plugin 'christoomey/vim-system-copy'
Plugin 'sickill/vim-pasta'
Plugin 'xolox/vim-misc'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'honza/vim-snippets'

" beauty
Plugin 'dylanaraps/wal.vim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'lukas-reineke/indent-blankline.nvim'
Plugin 'Yggdroot/indentLine'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'ap/vim-css-color'
Plugin 'vim-python/python-syntax'
Plugin 'plasticboy/vim-markdown'

" linting and completion
Plugin 'neomake/neomake'
Plugin 'fatih/vim-go'
Plugin 'habamax/vim-godot'
Plugin 'OrangeT/vim-csharp'

Plugin 'neoclide/coc.nvim', {'branch': 'release'}
call vundle#end()


" Section: nerdcommenter


" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1


" Section: FZF


set rtp+=~/.fzf
nnoremap <leader>o :FZF<CR>


" Section: neomake Linter configuration


" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000)
let g:neomake_open_list = 2
let g:neomake_python_enabled_makers = ['pyflakes', 'python']
let g:neomake_cpp_enabled_makers = ['clang++', 'g++']
let g:neomake_c_enabled_makers = ['clang', 'gcc']

" autoclose location list
augroup my_neomake_qf
    autocmd!
    autocmd QuitPre * if &filetype !=# 'qf' | lclose | endif
augroup END

"autoclose quick fix if only window
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END


" Section: coc.nvim


let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-tabnine',
                             \ 'coc-snippets', 'coc-html', 'coc-discord-rpc',
                             \ 'coc-sh', 'coc-python', 'coc-omnisharp',
                             \ 'coc-markdownlint', 'coc-jedi', 'coc-go',
                             \ 'coc-css', 'coc-cmake', 'coc-clangd',
                             \ 'coc-pyright']

if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

inoremap <silent><expr> <tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr> <s-tab> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col-1] =~# '\s'
endfunction

if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)


" Section: vimspector


let g:vimspector_enable_mappings = 'HUMAN'
packadd! vimspector
map <F2> :VimspectorReset


" Section: airline and tmux powerline


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


" Section: indent line


let g:indentLine_fileTypeExclude = ['markdown', 'json', 'tex']
let g:indentLine_char = '┆'
let g:indent_blankline_char = '┆'
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = 0
set list
" set listchars=tab:\┆·
set listchars=tab:\┆\ 


" Section: vim-go


" let g:go_snippet_engine = ""
let g:go_template_autocreate = 0
let g:go_code_completion_enabled = 0


" Section: easymotion


" Bind search keys to work with easy motion
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)


" Section: NerdTree


" toggle nerd tree
map <C-b> :NERDTreeToggle<CR>
"auto close vim if nerdtree is only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" Section: vim markdown


let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1


" Section: Key mappings


imap jj <ESC>

" add alt key support <M- > in normal mode
for i in range(65,90) + range(97,122)
  let c = nr2char(i)
  exec "map \e".c." <M-".c.">"
endfor

" Tab flow uses meta + direction
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

"autoclose and position cursor to write text inside
inoremap ' ''<left>
inoremap ` ``<left>
inoremap " ""<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
"
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
inoremap '<CR> '<CR>'<ESC>O
inoremap `<CR> `<CR>`<ESC>O
inoremap "<CR> "<CR>"<ESC>O
inoremap (<CR> (<CR>)<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap {<CR> {<CR>}<ESC>O

"autoclose 2 lines below adding ; and position cursor in the middle
inoremap ';<CR> '<CR>';<ESC>O
inoremap `;<CR> `<CR>`;<ESC>O
inoremap ";<CR> "<CR>";<ESC>O
inoremap (;<CR> (<CR>);<ESC>O
inoremap [;<CR> [<CR>];<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

"autoclose 2 lines below adding , and position cursor in the middle
inoremap ',<CR> '<CR>',<ESC>O
inoremap `,<CR> `<CR>`,<ESC>O
inoremap ",<CR> "<CR>",<ESC>O
inoremap (,<CR> (<CR>),<ESC>O
inoremap [,<CR> [<CR>],<ESC>O
inoremap {,<CR> {<CR>},<ESC>O
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

" retab
nnoremap <silent> <leader>r :set ts=2 noet <Bar> retab! <Bar> set et ts=4 <Bar> retab <CR>

" remove whitespace at end of lines
nnoremap <silent> <leader>w :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>


" Section: Color scheme


" python syntax highlighting helper
let g:python_hightlight_all = 1

" PaperColor papercolor
let g:PaperColor_Theme_Options = {
 \    'theme': {
 \        'default': {
 \            'allow_bold': 1,
 \            'allow_italic': 1
 \        }
 \    },
 \    'language': {
 \        'python': {
 \            'highlight_builtins': 1
 \        },
 \        'c': {
 \            'highlight_builtins': 1
 \        }
 \    }
 \ }

set termguicolors
set background=dark
colorscheme PaperColor

syntax enable
syntax sync fromstart

hi Normal guibg=NONE ctermbg=NONE
hi NonText ctermbg=NONE
set noshowmode

" gruvbox
" set termguicolors
" set background=dark
" colorscheme gruvbox
" syntax enable
" syntax sync fromstart
" hi Normal guibg=NONE ctermbg=NONE
" hi NonText ctermbg=NONE
" set noshowmode


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

function RemoveDuplicateLS()
    call CocAction('toggleSource', 'cs-2')
endfunction
nnoremap dld :call RemoveDuplicateLS()<cr>


" Section: Commands


command! -nargs=* T split | resize 15 | terminal <args>
command! -nargs=* VT vsplit | terminal <args>

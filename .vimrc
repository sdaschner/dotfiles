set encoding=utf-8
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent
set nowrap
set smartcase
set showmatch
set title
set ruler
set et
set relativenumber
set incsearch
set hlsearch
set autoread
set autowrite
set nobackup
set nowritebackup
set noswapfile
set nocompatible

" Allows buffers to be hidden if you modified a buffer
set hidden
filetype off
syntax on

inoremap jk <Esc>
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Opens a new empty buffer
nmap <leader>T :enew<CR>
" Moves to the next buffer
nmap <leader>l :bnext<CR>
" Moves to the previous buffer
nmap <leader>h :bprevious<CR>
" Closes the current buffer, moves to the previous one
nmap <leader>bd :bd<CR>
" Shows all open buffers and their status
nmap <leader>bl :ls<CR>
" Opens the last buffer
nnoremap <leader><leader> <C-^>

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

set encoding=utf-8
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set nowrap
set smartcase
set showmatch
set title
set ruler
set et
set number relativenumber
set scrolloff=4
set incsearch
set hlsearch
set autoread
set autowrite
set nobackup
set nowritebackup
set noswapfile
set nocompatible
" title required for i3 status checking, modified indicator at end
"set titlestring=%t%(\ \(%F\)%)%a\ -\ VIM%(\ %M%)
set titlestring=%(%F%)%a\ -\ VIM%(\ %M%)
set t_Co=16
" undo cursorlinenr underline (was introduced Aug '19)
hi CursorLineNr cterm=bold

" allows buffers to be hidden if you modified a buffer
set hidden
filetype off
syntax on

" removes possibility to define function keys that start with <Esc>
" see if has implications
set noesckeys

" configure netrw explorer
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" Vundle
"<<<<<<<<<<<<<<<<<<<< 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'mbbill/undotree'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'wellle/context.vim'

" UltiSnips for completion / templating
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'sdaschner/vim-snippets'
Plugin 'ervandew/supertab'

let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'


" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" something messes up this setting in the plugins
set expandtab

" fixes context ident for Markdown (context.vim)
function MyIndent(line)
    if &ft == 'markdown'
        " some custom implementation for markdown
        let indent = indent(a:line)
        if indent < 0
            return [indent, indent]
        endif
        let line = getline(a:line)
        let headings = match(line, '^*\+\zs\s')+1
        if headings <= 0
            let headings = match(line, '^#\+\zs\s')+1
            if headings <= 0
                let headings = 5
            endif
        endif
        return [indent+headings, indent]
    else
        " fall back to default implementation
        let indent = indent(a:line)
        return [indent, indent]
    endif
endfunction
let g:Context_indent = funcref('MyIndent')
let g:context_skip_regex = '^\s*$'

let mapleader = "\<Space>"

nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

inoremap <Up> <c-y>
inoremap <Down> <c-e>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <c-y>
noremap <Down> <c-e>

" presentation mode
noremap <Left> :silent bp<CR> :redraw!<CR>
noremap <Right> :silent bn<CR> :redraw!<CR>
nmap <F5> :set relativenumber! number! showmode! showcmd! hidden! ruler!<CR>
nmap <F2> :call DisplayPresentationBoundaries()<CR>
nmap <F3> :call FindExecuteCommand()<CR>

" jump to slides
nmap <F9> :call JumpFirstBuffer()<CR> :redraw!<CR>
nmap <F10> :call JumpSecondToLastBuffer()<CR> :redraw!<CR>
nmap <F11> :call JumpLastBuffer()<CR> :redraw!<CR>


" move lines with Ctrl + (Shift) +J/K
nnoremap <C-j> :m +1<CR>
nnoremap <C-k> :m -2<CR>
inoremap <C-j> <Esc>:m +1<CR>gi
inoremap <C-k> <Esc>:m -2<CR>gi
vnoremap <C-j> :m '>+1<CR>gvgv
vnoremap <C-k> :m '<-2<CR>gvgv

" opens a new empty buffer
nmap <leader>t :enew<CR>
" moves to the next buffer
nmap <leader>l :bnext<CR>
" moves to the previous buffer
nmap <leader>h :bprevious<CR>
" closes the current buffer, moves to the previous one
nmap <leader>bd :bd<CR>
" forces buffer close
nmap <leader>BD :bd!<CR>
" shows all open buffers and their status
nmap <leader>bl :ls<CR>
" toggles the paste mode
nmap <C-p> :set paste!<CR>
" toggles word wrap
nmap <leader>w :set wrap! linebreak<CR>
" toggles spell checking
nmap <C-]> :set spell! spelllang=en_us<CR>
" opens the last buffer
nnoremap <leader><leader> <C-^>
" adds a line of <
nmap <leader>a :normal 20i<<CR>
" makes Ascii art font
nmap <leader>2 :.!toilet -w 200 -f standard<CR>
nmap <leader>3 :.!toilet -w 200 -f small<CR>
" makes Ascii border
nmap <leader>1 :.!toilet -w 200 -f term -F border<CR>
" capitalize titles
nmap <leader>c :.!capitalize-title -<CR>
vnoremap <leader>c :.!capitalize-title -<CR>
" open netrw/fzf/search
nmap <leader>x :Explore<CR>
nmap <leader>n :Files<CR>
nmap <leader>f :Rg<CR>

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" system clipboard
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>y "+yy
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

nmap <leader>d <C-d>
nmap <leader>u <C-u>
vmap <leader>d <C-d>
vmap <leader>u <C-u>

" file operations
nmap <C-s> :w<CR>
nmap <C-q> :q<CR>

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" search highlighting color
highlight Search ctermfg=grey ctermbg=red
highlight Macro ctermfg=cyan
highlight Special ctermfg=red

" removes search highlighting
nnoremap <silent> <C-l> :nohl<CR><C-l>

" execute command
nmap <leader><Enter> !!zsh<CR>

" AsciiDoc preview
nmap <leader>v :w !asciidoc-view -<CR><CR>

" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
augroup encrypted
  au!
 
  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  " We don't want a swap file, as it writes unencrypted data to disk
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile
 
  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre *.gpg set bin
  autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null
 
  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost *.gpg set nobin
  autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
 
  " Convert all text to encrypted text before writing
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost *.gpg u
augroup END

function! JumpFirstBuffer()
  execute "buffer 1"
endfunction

function! JumpSecondToLastBuffer()
  execute "buffer " . (len(Buffers()) - 1)
endfunction

function! JumpLastBuffer()
  execute "buffer " . len(Buffers())
endfunction

function! Buffers()
  let l:buffers = filter(range(1, bufnr('$')), 'bufexists(v:val)')
  return l:buffers
endfunction

" Automatically source an eponymous <file>.vim or <file>.<ext>.vim if it exists, as a bulked-up
" modeline and to provide file-specific customizations.
function! s:AutoSource()
    let l:testedScripts = ['syntax.vim']
    if expand('<afile>:e') !=# 'vim'
        " Don't source the edited Vimscript file itself.
        call add(l:testedScripts, 'syntax.vim')
    endif

    for l:filespec in l:testedScripts
        if filereadable(l:filespec)
            execute 'source' fnameescape(l:filespec)
        endif
    endfor

    call FindExecuteCommand()
endfunction
augroup AutoSource
    autocmd! BufNewFile,BufRead * call <SID>AutoSource()
augroup END


set foldtext=SimpleFoldText()
set fillchars=fold:\ 
function SimpleFoldText()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
  return sub . ' >>>>>>'
endfunction

set foldlevelstart=20
set foldmethod=expr
set foldexpr=ListFolds()

function! ListFolds()
  let thisline = getline(v:lnum)
  if match(thisline, '^- ') >= 0
    return ">1"
  elseif match(thisline, '^  - ') >= 0
    return ">2"
  elseif match(thisline, '^    - ') >= 0
    return ">3"
  elseif match(thisline, '^      - ') >= 0
    return ">4"
  elseif match(thisline, '^        - ') >= 0
    return ">5"
  endif
  return "0"
endfunction


let g:presentationBoundsDisplayed = 0
function! DisplayPresentationBoundaries()
  if g:presentationBoundsDisplayed
    match
    set colorcolumn=0
    let g:presentationBoundsDisplayed = 0
  else
    highlight lastoflines ctermbg=darkred guibg=darkred
    match lastoflines /\%23l/
    set colorcolumn=80
    let g:presentationBoundsDisplayed = 1
  endif
endfunction

function! FindExecuteCommand()
  let line = search('\S*!'.'!:.*')
  if line > 0
    let command = substitute(getline(line), "\S*!"."!:*", "", "")
    execute "silent !". command
    execute "normal gg0"
    redraw
  endif
endfunction

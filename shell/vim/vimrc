""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General options.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Scheme and syntax.
colorscheme habamax
syntax on

" Tabline.
set showtabline=2

" Line number.
set number

" Tabs & indentation.
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Line wrapping.
set nowrap

" Search settings.
set ignorecase
set smartcase

" Appearance.
set list
set listchars=tab:‣‣,trail:·
set cursorline
set hlsearch

" Allow backspace on indent, end of line or insert mode start position.
set backspace=indent,eol,start

" Windows splitting.
set splitright
set splitbelow

" Mouse.
set mouse=a

" Buffer size.
set viminfo='100,<1000,s100,h

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General keymaps.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set leader key to space.
let mapleader=" "

" Use jk to exit insert mode.
inoremap jk <ESC>

" Clear search highlights.
nnoremap <leader>nh :nohl<CR>

" Delete single character without copying into register.
nnoremap x "_x"

" Increment/decrement numbers.
nnoremap <leader>+ <C-a>
nnoremap <leader>- <C-x>

" Split window vertically.
nnoremap <leader>sv <C-w>v
" Split window horizontally.
nnoremap <leader>sh <C-w>s
" Make split windows equal width & height.
nnoremap <leader>se <C-w>=
" Close current split window.
nnoremap <leader>sx :close<CR>

" Open new tab.
nnoremap <leader>to :tabnew<CR>
" Close current tab.
nnoremap <leader>tx :tabclose<CR>
" Go to next tab.
nnoremap <leader>tn :tabn<CR>
" Go to previous tab.
nnoremap <leader>tp :tabp<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype options.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup vimrc
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Trim whitespaces on save.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    autocmd BufRead,BufWritePre,FileWritePre * silent! %s/\s\+$//e
    autocmd BufRead,BufWritePre,FileWritePre * silent! %s/\%^\n\+//
    autocmd BufRead,BufWritePre,FileWritePre * silent! %s/\($\n\s*\)\+\%$//

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Templates.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    autocmd BufNewFile *.cpp 0r ~/.templates/cpp/competitive_programming/cp_main.cpp
    autocmd BufNewFile *.go 0r ~/.templates/go/competitive_programming/cp_main.go
    autocmd BufNewFile *.kt 0r ~/.templates/kotlin/competitive_programming/cp_main.kt
    autocmd BufNewFile *.rs 0r ~/.templates/rust/competitive_programming/cp_main.rs

    autocmd BufNewFile *.java 0r ~/.templates/java/competitive_programming/cp_main.java
    autocmd BufNewFile *.java %s/{{_file_name_}}/\=expand("%:t:r")/g

    autocmd BufNewFile *.c 0r ~/.templates/c/empty.c
    autocmd BufNewFile *.cs 0r ~/.templates/csharp/empty.cs
    autocmd BufNewFile *.py 0r ~/.templates/python/empty.py

    autocmd BufNewFile *.bash,*.sh,*.zsh 0r ~/.templates/bash/empty.sh.tpl
    autocmd BufNewFile *.bash,*.sh,*.zsh %s/#;; bash\n//g

    autocmd BufNewFile *.bash,*.c,*.cpp,*.cs,*.go,*.java,*.kt,*.py,*.rs,*.sh,*.zsh %s/{{_cursor_}}//g

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Make commands.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    autocmd BufEnter,BufWinEnter *.c setlocal makeprg=gcc\ -DCHEGORYU\ -Wall\ -Wextra\ -std=c2x\ -O2\ -o\ %<\ %
    autocmd BufEnter,BufWinEnter *.h,*.cpp,*.hpp setlocal makeprg=g++\ -DCHEGORYU\ -Wall\ -Wextra\ -std=c++20\ -O2\ -o\ %<\ %

    autocmd BufEnter,BufWinEnter *.cs setlocal makeprg=mcs\ -optimize\ -out:%<\ %
    autocmd BufEnter,BufWinEnter *.go setlocal makeprg=go\ build\ -o\ %<\ %
    autocmd BufEnter,BufWinEnter *.kt setlocal makeprg=kotlinc\ -include-runtime\ -d\ %<.jar\ %
    autocmd BufEnter,BufWinEnter *.rs setlocal makeprg=rustc\ --cfg\ chegoryu\ -O\ -o\ %<\ %

    autocmd BufEnter,BufWinEnter *.java setlocal makeprg=source_file=$(realpath\ %)\ &&\
        \ class_name=$(basename\ %<)\ &&\
        \ mkdir\ -p\ $(dirname\ $source_file)/classes/$class_name\ &&\
        \ cd\ $(dirname\ $source_file)/classes/$class_name\ &&\
        \ javac\ $source_file\ -d\ .\ &&\
        \ jar\ -c\ -f\ ../../$class_name.jar\ -e\ $class_name\ *.class

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Run keymaps.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    autocmd BufEnter,BufWinEnter *.c,*.h,*.cpp,*.hpp,*.go,*.rs nnoremap <buffer> <F5> :!time $(realpath %<)<CR>
    autocmd BufEnter,BufWinEnter *.cs nnoremap <buffer> <F5> :!time mono $(realpath %<)<CR>
    autocmd BufEnter,BufWinEnter *.java,*.kt nnoremap <buffer> <F5> :!time java -jar $(realpath %<.jar)<CR>
    autocmd BufEnter,BufWinEnter *.py nnoremap <buffer> <F5> :!time python3 $(realpath %)<CR>
    autocmd BufEnter,BufWinEnter *.bash,*.sh,*.zsh nnoremap <buffer> <F5> :!time bash $(realpath %)<CR>

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Make keymaps.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    autocmd BufEnter,BufWinEnter *.c,*.h,*.cpp,*.hpp,*.cs,*.go,*.java,*.kt nnoremap <buffer> <F9> :make<CR>
    autocmd BufEnter,BufWinEnter *.rs nnoremap <buffer> <F9> :make!<CR>

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Special options.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    autocmd BufEnter,BufWinEnter *.go setlocal noexpandtab

augroup END

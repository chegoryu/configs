colorscheme habamax
syntax on

set showtabline=2

set number

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

set ignorecase
set smartcase

set list
set listchars=tab:‣‣,trail:·
set cursorline

set backspace=indent,eol,start

set splitright
set splitbelow

set mouse=a
set viminfo='100,<1000,s100,h

augroup vimrc
    autocmd BufRead,BufWritePre,FileWritePre * silent! %s/\s\+$//e
    autocmd BufRead,BufWritePre,FileWritePre * silent! %s/\%^\n\+//
    autocmd BufRead,BufWritePre,FileWritePre * silent! %s/\($\n\s*\)\+\%$//

    autocmd BufNewFile *.cpp 0r ~/.templates/cpp/competitive_programming/cp_main.cpp
    autocmd BufNewFile *.go 0r ~/.templates/go/competitive_programming/cp_main.go
    autocmd BufNewFile *.rs 0r ~/.templates/rust/competitive_programming/cp_main.rs

    autocmd BufNewFile *.c 0r ~/.templates/c/empty.c
    autocmd BufNewFile *.cs 0r ~/.templates/csharp/empty.cs
    autocmd BufNewFile *.java 0r ~/.templates/java/empty.java
    autocmd BufNewFile *.kt 0r ~/.templates/kotlin/empty.kt
    autocmd BufNewFile *.py 0r ~/.templates/python/empty.py

    autocmd BufNewFile *.cpp,*.go,*.rs,*.c,*.cs,*.java,*.kt,*.py %s/{{_cursor_}}//g

    autocmd BufNewFile *.sh,*bash,*zsh 0r ~/.templates/bash/empty.sh.tpl
    autocmd BufNewFile *.sh,*.bash,*zsh %s/#;; bash\n//g
    autocmd BufNewFile *.sh,*.bash,*zsh %s/{{_cursor_}}//g

    autocmd BufEnter,BufWinEnter *.cpp setlocal makeprg=g++\ -DCH_EGOR\ -Wall\ -Wextra\ -std=c++20\ -O2\ -o\ %<\ %<.cpp
    autocmd BufEnter,BufWinEnter *.cpp nnoremap <buffer> <F9> :make<CR>
    autocmd BufEnter,BufWinEnter *.cpp nnoremap <buffer> <F5> :!time ./"%<"<CR>

    autocmd BufEnter,BufWinEnter *.go setlocal noexpandtab
augroup END

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

    autocmd BufNewFile *.sh,*.bash,*.zsh 0r ~/.templates/bash/empty.sh.tpl
    autocmd BufNewFile *.sh,*.bash,*.zsh %s/#;; bash\n//g
    autocmd BufNewFile *.sh,*.bash,*.zsh %s/{{_cursor_}}//g


    autocmd BufEnter,BufWinEnter *.c setlocal makeprg=gcc\ -DCHEGORYU\ -Wall\ -Wextra\ -std=c2x\ -O2\ -o\ %<\ %
    autocmd BufEnter,BufWinEnter *.h,*.cpp,*.hpp setlocal makeprg=g++\ -DCHEGORYU\ -Wall\ -Wextra\ -std=c++20\ -O2\ -o\ %<\ %

    autocmd BufEnter,BufWinEnter *.cs setlocal makeprg=mcs\ -optimize\ -out:%<\ %
    autocmd BufEnter,BufWinEnter *.go setlocal makeprg=go\ build\ -o\ %<\ %
    autocmd BufEnter,BufWinEnter *.java setlocal makeprg=javac\ %\ &&\ jar\ -c\ -f\ %<.jar\ -e\ $(basename\ %<)\ -C\ $(dirname\ $(realpath\ %<.class))\ $(basename\ %<.class)
    autocmd BufEnter,BufWinEnter *.kt setlocal makeprg=kotlinc\ -include-runtime\ -d\ %<.jar\ %
    autocmd BufEnter,BufWinEnter *.rs setlocal makeprg=rustc\ --cfg\ chegoryu\ -O\ -o\ %<\ %


    autocmd BufEnter,BufWinEnter *.c,*.h,*.cpp,*.hpp,*.go,*.rs nnoremap <buffer> <F5> :!time $(realpath %<)<CR>
    autocmd BufEnter,BufWinEnter *.cs nnoremap <buffer> <F5> :!time mono $(realpath %<)<CR>
    autocmd BufEnter,BufWinEnter *.java,*.kt nnoremap <buffer> <F5> :!time java -jar $(realpath %<.jar)<CR>
    autocmd BufEnter,BufWinEnter *.py nnoremap <buffer> <F5> :!time python3 $(realpath %)<CR>
    autocmd BufEnter,BufWinEnter *.sh,*.bash,*.zsh nnoremap <buffer> <F5> :!time bash $(realpath %)<CR>


    autocmd BufEnter,BufWinEnter *.c,*.h,*.cpp,*.hpp,*.cs,*.go,*.java,*.kt nnoremap <buffer> <F9> :make<CR>
    autocmd BufEnter,BufWinEnter *.rs nnoremap <buffer> <F9> :make!<CR>


    autocmd BufEnter,BufWinEnter *.go setlocal noexpandtab
augroup END

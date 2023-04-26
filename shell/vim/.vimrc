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
    autocmd BufNewFile *.rs 0r ~/.templates/rust/competitive_programming/cp_main.rs

    autocmd BufNewFile *.java 0r ~/.templates/java/competitive_programming/cp_main.java
    autocmd BufNewFile *.java %s/{{_file_name_}}/\=expand("%:t:r")/g

    autocmd BufNewFile *.c 0r ~/.templates/c/empty.c
    autocmd BufNewFile *.cs 0r ~/.templates/csharp/empty.cs
    autocmd BufNewFile *.kt 0r ~/.templates/kotlin/empty.kt
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
    " Filetype options.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    autocmd BufEnter,BufWinEnter *.go setlocal noexpandtab

augroup END

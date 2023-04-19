syntax on

set showtabline=2

set number

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

set ignorecase
set smartcase

set list
set listchars=tab:‣\ ,trail:·
set cursorline

set splitright
set splitbelow

set mouse=a
set viminfo='100,<1000,s100,h

nnoremap <F9> :set makeprg=g++\ -DCH_EGOR\ -Wall\ -Wextra\ -std=c++20\ -O2\ -o\ %<\ %<.cpp<CR>:make<CR>
nnoremap <C-F9> :set makeprg=g++\ -DCH_EGOR\ -Wall\ -Wextra\ -g\ -std=c++20\ -o\ %<\ %<.cpp<CR>:make<CR>
nnoremap <F5> :!time ./"%<"<CR>

let g:ycm_confirm_extra_conf=0

:autocmd BufNewFile *.cpp 0r ~/programs/templates/cpp/template.cpp

augroup vimrc
    autocmd BufRead,BufWritePre,FileWritePre * silent! %s/[\r \t]\+$//
augroup END

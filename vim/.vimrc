set exrc
set smartindent
set autoindent
set number
set shiftwidth=4
set tabstop=4
set expandtab
set mouse=a
set viminfo='100,<1000,s100,h
syntax on

nnoremap <F9> :set makeprg=g++\ -DCH_EGOR\ -Wall\ -Wextra\ -std=c++20\ -O2\ -o\ %<\ %<.cpp<CR>:make<CR>
nnoremap <C-F9> :set makeprg=g++\ -DCH_EGOR\ -Wall\ -Wextra\ -g\ -std=c++20\ -o\ %<\ %<.cpp<CR>:make<CR>
nnoremap <F5> :!time ./"%<"<CR>

let g:ycm_confirm_extra_conf=0

:autocmd BufNewFile *.cpp 0r ~/programs/templates/cpp/template.cpp

augroup vimrc
    autocmd BufRead,BufWritePre,FileWritePre * silent! %s/[\r \t]\+$//
augroup END

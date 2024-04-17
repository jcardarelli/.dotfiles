" https://github.com/dag/vim-fish
" syntax enable
" filetype plugin indent on

" Set up :make to use fish for syntax checking.
" this seems to break whether or not ':TSInstall fish' has been run
" compiler fish

" Set this to have long lines wrap inside comments.
setlocal textwidth=79

" Enable folding of block structures in fish.
setlocal foldmethod=expr

" Do I need this? 2024/04/04
" if &shell =~# 'fish$'
"     set shell=sh
" endif

""""""""""""""""""""""""""first step"""""""""""""""""""""""""""""

" apt update
" apt upgrade
" apt install vim git ctags
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" git clone https://github.com/tomasr/molokai.git
" mkdir ~/.vim/colors
" mv ~/.vim/bundle/molokai/color/molokai.vim ~/.vim/colors
" copy .vimrc from https://github.com/oliver-zeng/vim.git to ~/.vimrc
" vi ~/.vimrc
" :PluginInstall

"""""""""""""""""""""""""ctags & taglist"""""""""""""""""""""""""

" auto find tags path -> not work
set tags+=./tags
let Tlist_Ctags_Cmd='/usr/bin/ctags'
let Tlist_Auto_Open=1
let Tlist_Show_One_File=1
let Tlist_Use_SingleClick=1
let Tlist_Exit_OnlyWindow=1

function! UpdateCtags()
    let curdir=getcwd()
    while !filereadable("./tags")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./tags")
        !ctags -R --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extras=+q
    endif
    execute ":cd " . curdir
endfunction
autocmd BufWritePost *.c,*.h,*.cpp silent call UpdateCtags() | TlistUpdate

""""""""""""""""""""""""My Default Configs"""""""""""""""""""""""

colorscheme molokai
set cursorline
set cursorcolumn
" adjust the width of Tab 
" show Tab as >-, Trail Space as -
set tabstop=4
set shiftwidth=4
set expandtab
set list listchars=tab:>-,trail:-
" set search highlight
set hlsearch
" set search ignore case
set ignorecase
" set line number
set nu

"""""""""""""""""""""""""My Binding Key""""""""""""""""""""""""""

" better motion (by remap easymotion key)
map ' <Plug>(easymotion-s)

" easy comment (by NERDCommenter)
vmap / <plug>NERDCommenterToggle

" better search (by remap vimgrep)
nnoremap gd :vimgrep /<c-r>=expand("<cword>")<cr>/jg %<cr> \| :copen<cr>
nnoremap q :cclose<cr>
nnoremap gq :copen<cr>
nnoremap gf :vimgrep /<c-r>:/ **<cr> \| :copen<cr>
set switchbuf+=newtab

" better ESC
inoremap jk <Esc>

" remap redo edit
nnoremap U <C-r>

" better vi (by nerdtree)
nnoremap f :NERDTreeToggle<CR>

" better window move
nnoremap <C-h> <C-w><Left>
nnoremap <C-j> <C-w><Down>
nnoremap <C-k> <C-w><Up>
nnoremap <C-l> <C-w><Right>

" better delete
vnoremap x "_x

"""""""""""""""""""""""""""better remind"""""""""""""""""""""""""

" Default Complete
" <c-n>
"
" Global Delete
" :g!/<pattern>/d
" :g/<pattern>/d
"
" Substitue
" 1) choose line in virtual mode
" 2) :s/<old>/<new>
"
" Surround by vim-surround
" normal)
" ds - delete surround
" cs - change surround
" virtual)
" S - add surround
"
" Split Window
" :sp       - horizonal split
" :vsp      - vertical split
" :tabnew   - new tab split

"""""""""""""""""""""""""""""""vundle""""""""""""""""""""""""""""

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" vundle
Plugin 'VundleVim/Vundle.vim'

" fast motion
Plugin 'Lokaltog/vim-easymotion'
" fast surround
Plugin 'tpope/vim-surround'
" auto pairs
Plugin 'jiangmiao/auto-pairs'
" easy comment
Plugin 'scrooloose/nerdcommenter'
" easy vi
Plugin 'scrooloose/nerdtree'
" navigatoer
Plugin 'taglist.vim'

call vundle#end()
filetype plugin indent on

" How-to-use
" :PluginList          - check installed plugin
" :PluginInstall       - add new plugin, run to install new plugin
" :PluginClean         - remove installed plugin, run to uninstall plugin
" :h vundle


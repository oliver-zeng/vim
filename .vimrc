""""""""""""""""""""""""""First Step""""""""""""""""""""""""""

" $ apt update
" $ apt upgrade
" $ apt install vim git ctags
" $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" $ git clone https://github.com/tomasr/molokai.git ~/.vim/bundle
" $ mkdir ~/.vim/colors
" $ mv ~/.vim/bundle/molokai/color/molokai.vim ~/.vim/colors
" $ git clone https://github.com/oliver-zeng/vim.git ~/.vim
" $ mv ~/.vim/vim/.vimrc ~/.vimrc
" $ vi ~/.vimrc
" $ :PluginInstall

"""""""""""""""""""""""""Ctags & Taglist""""""""""""""""""""""

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

""""""""""""""""""""""""My Default Configs""""""""""""""""""""

" set color theme
colorscheme molokai
" set clipboard as default register
set clipboard=unnamedplus
" high light cursor
set cursorline
set cursorcolumn
" show Tab as >-, Trail Space as -
set list listchars=tab:>-,trail:-
" adjust the width of Tab
set tabstop=4
set shiftwidth=4
set expandtab
" set search highlight
set hlsearch
" set search ignore case
set ignorecase
" set line number
set nu
" support Chinese
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030
set termencoding=utf-8

"""""""""""""""""""""""""My Binding Key"""""""""""""""""""""""

" better motion (by remap easymotion key)
map <space>j <Plug>(easymotion-w)
map <space>k <Plug>(easymotion-b)
map w <Plug>(easymotion-lineforward)
map b <Plug>(easymotion-linebackward)

" easy comment (by NERDCommenter)
vmap / <plug>NERDCommenterToggle

" better search (by remap vimgrep)
" j     - do not jump to first match postion
" g     - show more result for multiple match within one line
" %     - current file
" *     - current dir
" **    - current dir & sub dir
" **/*  - sub dir
nnoremap q :cclose<cr>
nnoremap gq /<c-r>/<cr> \|'' \| :vimgrep /<c-r>//gj %<cr> \| :copen<cr>
nnoremap gd /<c-r>=expand("<cword>")<cr><cr> \|'' \| :vimgrep /<c-r>//gj %<cr>
nnoremap gf :vimgrep /<c-r>//gj **<cr> \| :copen<cr>
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

"""""""""""""""""""""""""""Better Remind""""""""""""""""""""""

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

"""""""""""""""""""""""""""""YCM"""""""""""""""""""""""""""

" git ssh clang python3 vim-python cmake build-essential
" vim --version | grep python
" python3 install.py --system-libclang --clangd-completer --clang-completer
" 根据自己需求自己加选项
" ( python3 install.py --all )

" ycm 指定 ycm_extra_conf.py
" add include path to ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'

"disable ycm 语法检查
"let g:ycm_enable_diagnostic_signs = 0
"let g:ycm_enable_diagnostic_highlighting = 0

"""""""""""""""""""""""""""""Vundle"""""""""""""""""""""""""""

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
" easy shuffle files
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" navigatoer
Plugin 'taglist.vim'
" complete
Plugin 'ycm-core/YouCompleteMe'

call vundle#end()
filetype plugin indent on

" How-to-use
" :PluginList          - check installed plugin
" :PluginInstall       - add new plugin, run to install new plugin
" :PluginClean         - remove installed plugin, run to uninstall plugin
" :h vundle


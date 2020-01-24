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

""""""""""""""""""status line"""""""""""""

let g:word_count="<unknown>"
function WordCount()
    return g:word_count
endfunction
function UpdateWordCount()
    let lnum = 1
    let n = 0
    while lnum <= line('$')
        let n = n + len(split(getline(lnum)))
        let lnum = lnum + 1
    endwhile
    let g:word_count = n
endfunction
" Update the count when cursor is idle in command or insert mode.
" Update when idle for 1000 msec (default is 4000 msec).
set updatetime=1000
augroup WordCounter
au! CursorHold,CursorHoldI * call UpdateWordCount()
augroup END
" Set statusline, shown here a piece at a time
set statusline+=%<%F
set statusline+=%M" modified flag
" file type
"set statusline+=%y
" separator from left to right justified
set statusline+=%=
set statusline+=\ total\ %{WordCount()}\ words,
" percentage through the file
set statusline+=\ %l/%L\ lines,\ %P
set laststatus=2

""""""""""""""""""""""""My Default Configs""""""""""""""""""""
" set color theme
colorscheme molokai
" set clipboard as default register
set clipboard=unnamedplus
" high light cursor
set cursorline
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
" set syntax highlight
syntax enable
" support Chinese
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030
set termencoding=utf-8

"""""""""""""""""""""""""My Binding Key"""""""""""""""""""""""

" fast compile & run
map <s-d> <ESC>:w<CR> <ESC>:!g++ -fsanitize=address -fno-omit-frame-pointer -O1 -g -std=c++11 % -o %< && gdb %<<CR>
"map <F5> <ESC>:w<CR> <ESC>:!g++ -fsanitize=address -fno-omit-frame-pointer -O1 -g -std=c++11 % -o %< && ./%<<CR>

" better motion (by remap easymotion key)
"map <space>j <Plug>(easymotion-w)
"map <space>k <Plug>(easymotion-b)
map <space> <Plug>(easymotion-s)
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

" better ESC
inoremap jk <Esc>

" remap redo edit
nnoremap U <C-r>

" better vi (by nerdtree)
nnoremap f :NERDTreeToggle<CR>

" disable auto create .swap file
set noswapfile

" better delete
vnoremap x "_x
nnoremap x "_x

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

"""""""""""""""""""""""Vim-EasyComplete""""""""""""""""""""
imap <Tab>   <Plug>EasyCompTabTrigger
imap <S-Tab> <Plug>EasyCompShiftTabTrigger
let g:pmenu_scheme = 'dark'

" minibuf
let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1 
"let g:miniBufExplMapCTabSwitchBufs = 1 
"解决FileExplorer窗口变小问题  
"let g:miniBufExplForceSyntaxEnable = 1  
"let g:miniBufExplorerMoreThanOne=2

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
" EasyComplete 插件和 Dictionary 词表
Plugin 'jayli/vim-easycomplete'
Plugin 'jayli/vim-dictionary'
" SnipMate 携带的四个插件
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
" Jedi
Plugin 'davidhalter/jedi-vim'
" minibuf
Plugin 'minibufexpl.vim'

call vundle#end()
filetype plugin indent on

" How-to-use
" :PluginList          - check installed plugin
" :PluginInstall       - add new plugin, run to install new plugin
" :PluginClean         - remove installed plugin, run to uninstall plugin
" :h vundle


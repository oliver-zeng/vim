""""""""""""""""""""""""""First Step""""""""""""""""""""""""""

" $ apt update
" $ apt upgrade
" $ apt install vim git ctags
" $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" $ mkdir ~/.vim/colors
" $ git clone https://github.com/tomasr/molokai.git ~/.vim/colors
" $ mv ~/.vim/colors/molokai/color/molokai.vim ~/.vim/colors
" $ git clone https://github.com/oliver-zeng/vim.git ~/.vim
" $ git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
" $ ~/.fzf/install
" $ mv ~/.vim/vim/.vimrc ~/.vimrc
" $ vi ~/.vimrc
" $ :PluginInstall

"""""""""""""""""""""""""Ctags & Taglist""""""""""""""""""""""

" auto find tags path -> not work
set tags+=./tags
"let Tlist_Ctags_Cmd='/usr/bin/ctags'
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
map <C-n> : Tlist<CR>            " 绑定快捷键，手动打开
"let Tlist_Auto_Open=1           " 在启动vim后，自动打开taglist窗口
let Tlist_Use_Right_Window=0    " 1为让窗口显示在右边，0位左边
let Tlist_Show_One_File=1
let Tlist_Use_SingleClick=1
let Tlist_File_Fold_Auto_Close=1" 同时显示多个文件中的tag，taglist只显示当前
let Tlist_Exit_OnlyWindow=1     " 当taglist是最后一个分割窗口时，自动退出vim

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

" set color theme solarized
set rtp+=~/.vim/bundle/vim-colors-solarized
let g:solarized_termcolors=256
set t_Co=256
set background=dark
colorscheme solarized
" Powerline
set laststatus=2 " 0 不显式状态行, 1 仅当窗口多于一个时显示状态行, 2 总是显式状态行
set noshowmode " 显示你处在什么模式下面 
" set clipboard as default register
set clipboard=unnamedplus
" high light cursor
set cursorline
" show Tab as >-, Trail Space as -
set list listchars=tab:>-,trail:-
" adjust the width of Tab
set tabstop=4       "tab空格数"
set shiftwidth=4    "缩进空格数"
set expandtab
" auto edit
set autoread        " 自动载入
set autowrite       " 自动把内容写回文件
set nobackup        " 不产生~备份文件
" better search
set hlsearch        " set search highlight
set incsearch       " 在输入的同时开始查找
set ignorecase      " set search ignore case
set smartcase       " 如果搜索模式包含大小写字母，不使用ignorecase
" set line number
set nu
" set syntax highlight
syntax enable
" support Chinese
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030
set termencoding=utf-8
" disable auto create .swap file
set noswapfile
" make backspace better
set backspace=indent,eol,start
" 记住文件上次编辑的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"""""""""""""""""""""""""My Binding Key"""""""""""""""""""""""

" Compiler Mappings based Filetype
" C++ Compiler
autocmd FileType cpp map <s-d> <ESC>:w<CR> <ESC>:!g++ -fsanitize=address -fno-omit-frame-pointer -O1 -g -std=c++11 % -o out_%< && gdb out_%<<CR>
" C Compiler
"autocmd FileType c nnoremap <buffer> <C-i> :!gcc % && ./a.out <CR>
" C++ Compiler
"autocmd FileType cpp nnoremap <buffer> <C-i> :!g++ % && ./a.out <CR>
" Python Interpreter
"autocmd FileType python nnoremap <buffer> <C-i> :!python % <CR>
" Bash script
"autocmd FileType sh nnoremap <buffer> <C-i> :!sh % <CR>

" fast compile & run
map <s-d> <ESC>:w<CR> <ESC>:!g++ -fsanitize=address -fno-omit-frame-pointer -O1 -g -std=c++11 % -o out_%< && gdb %<<CR>
"map <F5> <ESC>:w<CR> <ESC>:!g++ -fsanitize=address -fno-omit-frame-pointer -O1 -g -std=c++11 % -o out_%< && ./%<<CR>

" better motion (by remap easymotion key)
map <space> <Plug>(easymotion-s)
map w <Plug>(easymotion-lineforward)
map b <Plug>(easymotion-linebackward)
inoremap h<Tab> <Left>
inoremap j<Tab> <Down>
inoremap k<Tab> <Up>
inoremap l<Tab> <Right>
nnoremap <C-h> <C-w><Left>
nnoremap <C-j> <C-w><Down>
nnoremap <C-k> <C-w><Up>
nnoremap <C-l> <C-w><Right>

" easy comment (by NERDCommenter)
vmap / <plug>NERDCommenterToggle

" open recent files
nmap <C-o> :browse oldfiles<CR>

" fuzzy search
"use $which fzf to set bash cmd path
set rtp+=~/.fzf=/
"nmap <C-p> :Files<CR>
" :echo expand('%:t')       current file name
" :echo expand('%:p')       current file full path
" :echo expand('%:p:h')     current file direcotry without file name
nmap <C-p> :Files %:p:h<CR>
nmap <C-f> :Lines<CR>
nmap <C-e> :Buffers<CR>
let g:fzf_action = { 'ctrl-e': 'edit' }

" better search (by remap vimgrep)
" j     - do not jump to first match postion
" g     - show more result for multiple match within one line
" %     - current file
" *     - current dir
" **    - current dir & sub dir
" **/*  - sub dir
nnoremap q :cclose<cr>
nnoremap gq /<c-r>/<cr> \|'' \| :vimgrep /<c-r>//j %<cr> \| :copen<cr>
nnoremap gd /<c-r>=expand("<cword>")<cr><cr> \|'' \| :vimgrep /<c-r>//j %<cr>
"nnoremap gf :vimgrep /<c-r>//j **<cr> \| :copen<cr>

" better ESC
inoremap jk <Esc>
inoremap kj <Esc>

" remap redo edit
nnoremap U <C-r>

" better vi (by nerdtree)
" open
nnoremap f :NERDTreeFind<CR>
" close
nnoremap F :NERDTreeToggle<CR>

" better delete
vnoremap x "_x
nnoremap x "_x
" copy to clipboard
vnoremap y "+y
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
" :vs       - vertical split
" :tabe     - new tab split
" :Ve       - base current path, split new file
" :Ex       - base current path, change current file

" w3m (sudo apt install w3m)
" :!w3m $HTTP
" :r !w3m $HTTP [-dump]

"""""""""""""""""""""""Vim-EasyComplete""""""""""""""""""""

"imap <Tab>   <Plug>EasyCompTabTrigger
"imap <S-Tab> <Plug>EasyCompShiftTabTrigger
"let g:pmenu_scheme = 'dark'

"""""""""""""""""""""""ycm-Complete""""""""""""""""""""

set completeopt=longest,menu
" 全局配置文件
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
" 注释里的输入也能补全
let g:ycm_complete_in_comments = 1
" 字符串中的输入也能补全
let g:ycm_complete_in_strings = 1
" 注释和字符串中文字也收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1

"""""""""""""""""""""""""""""Vundle"""""""""""""""""""""""""""

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" vundle
" $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
Plugin 'VundleVim/Vundle.vim'

" solarized
Plugin 'altercation/vim-colors-solarized'
" Powerline
Plugin 'Lokaltog/vim-powerline'
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
" fuzzy search file
" $ git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
" $ ~/.fzf/install
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plugin 'junegunn/fzf.vim'
" navigatoer
Plugin 'taglist.vim'
" complete
" ycm
" cd ~/.vim/bundle/YouCompleteMe
" git submodule update --init --recursive
" python3 install.py --all
Plugin 'Valloric/YouCompleteMe'
" instead (1~3)
" 1. EasyComplete 插件和 Dictionary 词表
"Plugin 'jayli/vim-easycomplete'
"Plugin 'jayli/vim-dictionary'
" 2. SnipMate 携带的四个插件
"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmate'
"Plugin 'honza/vim-snippets'
" 3. Jedi (complete for python)
"Plugin 'davidhalter/jedi-vim'

call vundle#end()
filetype plugin indent on

" How-to-use
" :PluginList          - check installed plugin
" :PluginInstall       - add new plugin, run to install new plugin
" :PluginClean         - remove installed plugin, run to uninstall plugin
" :h vundle


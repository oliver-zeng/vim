# mac vim

https://blog.csdn.net/fangkailove/article/details/106365539

```sh
$ brew install vim
# brew 是把vim装在/usr/local/Cellar，并做了链接到 /usr/local/opt
$ vi ~/.zshrc
# alias vi='/usr/local/Cellar/vim/8.2.1500/bin/vim'
```

cd ~/.vim/YouCompleteMe
git submodule update --init --recursive
python3 install.py --all

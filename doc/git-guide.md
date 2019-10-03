
# Git Usage
## First Usage

1. install ssh
'''
 $ apt install openssh
'''

2. check by vi ~/.gitconfig
'''
$ git config --global user.name "xx"
$ git config --global user.email "yy@qq.com"
'''

3. path -> key -> key
'''
$ ssh-keygen -t rsa -C "yy@qq.com"
'''

4. copy ~/.ssh/id_rsa.pub to "github -> settings -> ssh and gpg keys"

5. get new_rep name by "github -> new repository"
'''
$ git init
$ git add README.md
$ git commit -m "first commit"
$ git remote add origin https://github.com/oliver-zeng/new_repo.git
$ git push -u origin master
'''


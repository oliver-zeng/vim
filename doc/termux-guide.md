# termux-guidline
## first usage
```
apt update
apt upgrade
```
## build command
### cpp
#### 1. install
```
apt install clang
```
#### 2. usage
```
clang xx.c
clang++ xx.cpp
```
### python3
#### 1. install
```
apt install python
```
#### 2. usage
```
python xx.py
```
### javascript
#### 1. install
```
apt install nodejs
```
#### 2. usage
```
node xx.js
```
### java
#### 1. install
```
apt install ecj
apt install dx
apt install termux-tools
```
#### 2. configure
##### 2.1. add ~/.vim/ecj.sh
```
#!/usr/bin/sh
ecj $1
arg1=$1
java_name=${arg1%.*}
dx --dex --output="$java_name.dex" "$java_name.class"
dalvikvm -cp "$java_name.dex" "$java_name"

```
##### 2.2. source ~/.bashrc
```
alias java='sh ~/.vim/ecj.sh'
```
##### 2.3. usage
```
java xx.java
```

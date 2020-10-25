# mac shell

[TOC]

## 使用 zsh

```sh
# 查看安装的 shell
cat /etc/shells

# 查看当前使用的 shell
echo $SHELL

# 使用 brew 更新 zsh
brew install zsh

# 切换为 zsh，重启终端即可使用 zsh
chsh -s /bin/zsh
```

## oh-my-zsh（zsh插件管理平台）

### 安装

```sh
# 打开网站 https://www.ipaddress.com/ 查询一下 raw.githubusercontent.com对应的IP地址
# 在hosts中加入以下内容后，重启shell
# 199.232.68.133 raw.githubusercontent.com
# 199.232.68.133 user-images.githubusercontent.com
# 199.232.68.133 avatars2.githubusercontent.com
# 199.232.68.133 avatars1.githubusercontent.com

# github 上 oh-my-zsh 官方网址 https://github.com/robbyrussell/oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### 配置主题

```sh
# 修改 ~/.zshrc 中 ZSH_THEME 的值
# 可选主题列表 https://github.com/ohmyzsh/ohmyzsh/wiki/themes
# 当设置为 ZSH_THEME=random 时，每次打开终端都会使用一种随机的主题

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
```

### 配置插件

个性化插件目录 $ZSH/custom/plugins
系统插件目录 $ZSH/plugins
在目录下新建一个名为PLUGIN_NAME的文件夹，把插件拷贝进去
插件的名称应该为PLUGIN_NAME.plugin.zsh

#### incr

1. 下载 incr 自动补全插件 http://mimosa-pudica.net/src/incr-0.2.zsh 到 ~/.oh-my-zsh/custom/plugins/incr/incr.plugin.zsh
2. 在 ~/.zshrc 中自动load的 plugins 里添加 incr
3. 更新配置 source ~/.zshrc

```sh
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  #incr
)
```

#### 更多插件
https://hufangyun.com/2017/zsh-plugin/
https://www.jianshu.com/p/7d2f7dc4c34f

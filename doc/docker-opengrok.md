# docker opengrok

[TOC]

## 快速操作

```sh
// <step1> 建立存放源码路径
$ rm -rf ~/opengrok
$ makedir -P ~/opengrok/src/ ~/opengrok/etc/ ~/opengrok/data/

// <step2> 将源码拷贝到 ~/opengrok/src/ 中

// <step3> 启动容器
$ docker run -d \
    --name opengrok \
    -p 8080:8080/tcp \
    -e REINDEX="0" \
    -v ~/opengrok/src/:/opengrok/src/ \
    -v ~/opengrok/etc/:/opengrok/etc/ \
    -v ~/opengrok/data/:/opengrok/data/ \
    opengrok/docker:latest

// <step4> 手动更新索引
$ docker exec $(docker ps | grep opengrok | grep -oE "^[0-9a-z]+") /scripts/index.sh
```

## 说明
### 自动同步

通过 REINDEX 设定自动同步更新 /opengrok/src/ 中索引的时间，默认为每 10 分钟
设为 n 表示 n 分钟，若设为 0 则表示 disable 自动同步
手动同步命令为 `docker exec <container> /scripts/index.sh`

[同步脚本内容](https://github.com/OpenGrok/docker/blob/master/scripts/index.sh)
```sh
#!/bin/bash

LOCKFILE=/var/run/opengrok-indexer
URI="http://localhost:8080"

if [ -f "$LOCKFILE" ]; then
	date +"%F %T Indexer still locked, skipping indexing"
	exit 1
fi

touch $LOCKFILE

if [ -z $NOMIRROR ]; then
	date +"%F %T Mirroring starting"
	opengrok-mirror --all --uri "$URI"
	date +"%F %T Mirroring finished"
fi

date +"%F %T Indexing starting"
opengrok-indexer \
    -a /opengrok/lib/opengrok.jar -- \
    -s /opengrok/src \
    -d /opengrok/data \
    -H -P -S -G \
    --leadingWildCards on \
    -W /var/opengrok/etc/configuration.xml \
    -U "$URI" \
    $INDEXER_OPT "$@"
date +"%F %T Indexing finished"

rm -f $LOCKFILE
```

### 使用 docker-compose 

用 docker-compose ([mac docker下默认安装，其他OS需手动安装](https://docs.docker.com/compose/install/)) 执行下面内容的 docker-compose.yml

```
version: "3"

# More info at https://github.com/oracle/opengrok/docker/
services:
  opengrok:
    container_name: opengrok
    image: opengrok/docker:latest
    ports:
      - "8080:8080/tcp"
    environment:
      REINDEX: '60'
    # Volumes store your data between container upgrades
    volumes:
       - '~/opengrok/src/:/opengrok/src/'  # source code
       - '~/opengrok/etc/:/opengrok/etc/'  # folder contains configuration.xml
       - '~/opengrok/data/:/opengrok/data/'  # index and other things for source code
```

在 docker-compose.yml 所在路径下执行 `docker-compose up -d` 效果等同于执行下面的命令

```
docker run -d \
    --name opengrok \
    -p 8080:8080/tcp \
    -e REINDEX="60" \
    -v ~/opengrok/src/:/opengrok/src/ \
    -v ~/opengrok/etc/:/opengrok/etc/ \
    -v ~/opengrok/data/:/opengrok/data/ \
    opengrok/docker:latest
```

### 拉最新镜像

```
docker pull opengrok/docker
```

### 镜像源码

```
git clone https://github.com/oracle/opengrok.git
cd opengrok
docker build -t opengrok-dev .
docker run -d -e REINDEX="1440" -v ~/opengrok/src:/opengrok/src -p 8080:8080 opengrok-dev
```

### 参考 https://hub.docker.com/r/opengrok/docker/

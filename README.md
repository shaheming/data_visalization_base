```shell
$ docker-compose up
$ docker-compose run --rm web bin/rails c
$ docker-compose stop
```

## 看容器内的进程

```shell
$ docker top daemon_dave	
```

### docker 卷里面储存的数据

```shell
$ screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty
$ ls -ltrh /var/lib/docker/volumes
```

能够看到 docker 里面的挂在的卷的数据

`Ctrl-a d` 来退出

删除所有的

```shell
$ docker stop $(docker ps -a -q)
$ docker rm $(docker ps -a -q)
```

docker compose

`docker-compose version 1.18.0`

```shell
$ sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
$ docker-compose --version #测试Docker Compose是否工作
```

### 第一次部署

```shell
md my_website
cd my_website
git clone
ln -s 
#production
export SERVER_IP=$(curl -s ip.cn | grep -oE "[0-9.]+")
#deveopent
# example 111.231.92.xxx
export SERVER_IP="0.0.0.0"
export RAILS_ENV=production
export SERVER_PORT="88"
docker-compose up >> 'docker-compose.log' 2>&1 &
# use rake secret to generate code
echo >> ~/.zshrc "export SECRET_KEY_BASE=2aaa2973ecf9ea5f4a2b1fb8c174fd8bfa70107c040e9b494aa9e0b73589b14e3fc12780ab9b3522b8f12ef166b67663a70c2ff7867f4c22430d7ab541304db4"

```

### 第二次部署

```shell
bin/update
```

### rails g 
```shell
docker run --rm  railsdockercompose_web rails g model log
docker  exec  -it railsdockercompose_web_1 /bin/bash
dbash railsdockercompose_web_1
```


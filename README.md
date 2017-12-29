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



```shell
 $ sudo docker run -d -p 6379 --name redis jamtur01/redis
```



```shell
$ sudo docker network create app
```



```shell
$ docker run -d --net=app --name db jamtur01/redis
```



删除所有的

```shell
$ docker stop $(docker ps -a -q)
$ docker rm $(docker ps -a -q)
```



```
$ docker volume rm machinelearning_bundle
```

拉了代码之后 bin/update
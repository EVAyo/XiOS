# Docker常用命令



## 一、帮助命令

```shell
$ docker version  			# 显示docker的版本信息
$ docker info						# 显示docker的系统信息，包括镜像和容器的数量
$ docker [命令] --help   # 万能命令
```

官网帮助文档：https://docs.docker.com/reference/

![](media_Docker/010.jpg)



## 二、镜像命令

### 2.1、查看本地镜像

```shell
$ docker images   # 查看所有本地主机上的镜像

REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              bf756fb1ae65        8 months ago        13.3kB

# 解释
REPOSITORY 	镜像的仓库源
TAG 				镜像的标签
IMAGE ID 		镜像的id
CREATED 		镜像的创建时间
SIZE 				镜像的大小

# 可选项
$ docker images --help

Options:
  -a, --all             Show all images (default hides intermediate images)
  											# 列出所有镜像
  -q, --quiet           Only show numeric IDs 
  											# 只显示镜像的id
```



### 2.2、搜索镜像

#### 1. 命令行搜索

```shell
$ docker search <镜像名>  # 搜索镜像

NAME        DESCRIPTION        STARS        OFFICIAL        AUTOMATED
mysql       MySQL is a widely used, open-source relation…   9974   [OK]                
mariadb     MariaDB is a community-developed fork of MyS…   3651   [OK]                
mysql/mysql-server  Optimized MySQL Server Docker images. Create…   727   [OK]

# 可选项
Options:
  -f, --filter filter   Filter output based on conditions provided
  											# 过滤
# eg
  --filter=STARS=3000   # 搜索出来的镜像Stars大于3000
```

![](media_Docker/012.jpg)



#### 2. 网页搜索 [Docker Hub](https://hub.docker.com/)

![](media_Docker/011.jpg)



### 2.3、下载镜像

```shell
$ docker pull <镜像名>[:tag]

$ docker pull mysql
Using default tag: latest   	# 若不写tag，则默认latest
latest: Pulling from library/mysql
d121f8d1c412: Pull complete 	# 分成下载，docker iamge核心：联合文件系统
f3cebc0b4691: Pull complete 
1862755a0b37: Pull complete 
489b44f3dbb4: Pull complete 
690874f836db: Pull complete 
baa8be383ffb: Pull complete 
55356608b4ac: Pull complete 
dd35ceccb6eb: Pull complete 
429b35712b19: Pull complete 
162d8291095c: Pull complete 
5e500ef7181b: Pull complete 
af7528e958b6: Pull complete 
Digest: sha256:e1bfe11693ed2052cb3b4e5fa356c65381129e87e38551c6cd6ec532ebe0e808 # 签名
Status: Downloaded newer image for mysql:latest
docker.io/library/mysql:latest  # 真实地址

# 等价
$ docker pull mysql
$ docker pull docker.io/library/mysql:latest  

# 指定版本
$ docker pull mysql:5.7
5.7: Pulling from library/mysql
d121f8d1c412: Already exists		# 公用
f3cebc0b4691: Already exists 
1862755a0b37: Already exists 
489b44f3dbb4: Already exists 
690874f836db: Already exists 
baa8be383ffb: Already exists 
55356608b4ac: Already exists 
277d8f888368: Pull complete 
21f2da6feb67: Pull complete 
2c98f818bcb9: Pull complete 
031b0a770162: Pull complete 
Digest: sha256:14fd47ec8724954b63d1a236d2299b8da25c9bbb8eacc739bb88038d82da4919
Status: Downloaded newer image for mysql:5.7
docker.io/library/mysql:5.7
```

![](media_Docker/013.jpg)



### 2.4、删除镜像

```shell
$ docker rmi -f <镜像id/镜像名> 		# 删除指定的镜像
$ docker rmi -f <镜像id> <镜像id> <镜像id>  # 删除多个镜像
$ docker rmi -f $(docker images -aq) # 删除全部镜像

# 等价
$ docker rmi
$ docker image rm
```

#### 1. 通过镜像名删除

```shell
$ docker rmi -f hello-world
```

#### 2. 通过镜像ID删除

```shell
$ docker rmi -f ef08065b0a30
# -f 强制 
# ef08065b0a30 镜像ID

$ docker rmi -f $(docker images -aq)
# $() 作为参数传入
# docker iamges -aq 查询所有镜像
# 最后通过循环逐个删除所有镜像
```



## 三、容器命令

> **前提**：我们有了镜像才可以创建容器，这里我们下载一个centos镜像进行测试。
>
> ```shell
> $ docker pull centos
> ```



### 3.1、新建容器并启动

```shell
$ docker run [可选项] <镜像名>

# 参数说明
--name="Name"  	容器名字 tomcat01、tomcat02，用来区分容器
-d 							后台运行方式
-it 						使用交互方式运行，进入容器查看内容
-p							指定容器的端口 -p 8080:8080
		-p IP:主机端口:容器端口
		-p 主机端口:容器端口 （常用）
		-p 容器端口
		容器端口
-P 							随机指定端口

# 测试，启动并进入容器
[root@iZbp1hyj00tfq6s5xxxxxxx /]# docker run -it centos /bin/bash
[root@8a6ab117185d /]# ll
bash: ll: command not found
[root@8a6ab117185d /]# ls
bin  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
[root@8a6ab117185d /]# exit
exit

# 测试结论
centos创建的容器并不完整，只是包含基础功能，例如：ll命令不能识别；
文件目录大体一致，但并不完成相同；
```



### 3.2、列出所有运行的容器

```shell
$ docker ps   		# 列出当前所有运行的容器

# 可选项
-a 		# 列出所有容器
-n=?  # 列出最近创建的容器
-q 		# 只显示容器ID

# eg
$ docker ps -a -n=1   # 显示最近的一个容器
$ docker ps -aq				# 列出容器ID
```



### 3.3、退出容器

```shell
$ exit	  # 停止容器并退出
Ctrl + p + q  # 容器不停止，退出

# 测试
[root@iZbp1hyj00tfq6s5ka3klmZ /]# docker run -it centos /bin/bash
[root@8d0d7b38ac2d /]# [root@iZbp1hyj00tfq6s5ka3klmZ /]# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
8d0d7b38ac2d        centos              "/bin/bash"         38 seconds ago      Up 37 seconds                           wonderful_rosalind
```



### 3.4、进入容器

```shell
# 方式一
$ docker exec -it <容器id> <bash shell>
# 测试
[root@iZbp1hyj00tfq6sxxxxxxx /]# docker exec -it 8d0d7b38ac2d /bin/bash
[root@8d0d7b38ac2d /]# 

# 方式二
$ docker attach <容器id>
# 测试
[root@iZbp1hyj00tfq6s5ka3klmZ /]# docker attach 8d0d7b38ac2d
[root@8d0d7b38ac2d /]# 

# 对比
$ docker exec     # 进入容器后开启一个新终端
$ docker attach		# 进入容器正在执行的终端，不会开启新终端
```



### 3.5、删除容器

```shell
$ docker rm <容器id>   			# 删除指定容器，不能删除运行中的容器
$ docker rm -f <容器id> 		# 可删除运行中的容器
$ docker rm $(docker ps -aq) 			# 删除所有的容器
$ docker ps -a -q|xargs docker rm # 删除所有的容器
```



### 3.6、启动和停止容器

```shell
$ docker start <容器id> 			# 启动容器
$ docker restart <容器id> 		# 重启容器
$ docker stop <容器id> 				# 停止当前正在运行的容器
$ docker kill <容器id> 				# 强制停止当前容器
```



## 四、常用的其他命令

### 4.1、后台启动容器

```shell
$ docker run -d centos

# 问题：查看 docker ps 时，发现 centos 停止了
# 原因：常见的坑，docker 容器使用后台运行，就必须要有一个前台进程，docker发现没有应用，就会自动停止。
# nginx 容器启动后，发现自己没有提供服务，就会立刻停止，就没有程序了。
```



### 4.2、查看日志 

视频地址：https://www.bilibili.com/video/BV1og4y1q7M4?p=11

```shell
$ docker logs
```

![](media_Docker/014.jpg)



### 4.3、查看容器中进程信息

```shell
$ docker top <容器ID>

# 测试 
$ docker top 8d0d7b38ac2d
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
root                12540               12523               0                   17:07               ?                   00:00:00            /bin/bash
```



### 4.4、查看容器的元数据

```shell
$ docker inspect <容器ID>
```



### 4.5、从容器内拷贝到主机上

```shell
$ docker cp <容器id:容器内路径> <目的主机路径>

# 测试
$ docker cp 8d0d7b38ac2d:/home/test.java /home
```














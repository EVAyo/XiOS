[Jenkins，docker实现自动化部署（持续交互）](https://developer.aliyun.com/article/611302)



[Official Jenkins Docker image](https://github.com/jenkinsci/docker)



[Jenkins Docs](https://www.jenkins.io/doc/)

[Jenkins Docs - Installing Jenkins](https://www.jenkins.io/doc/book/installing/)







# Jenkins安装方式

云端部署Jenkins有多种方式：

1. 下载Jenkins包上传到阿里云，手动安装
2. Docker





## 一、search Jenkins

```shell
$ docker search jenkins
NAME                                   DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
jenkins                                Official Jenkins Docker image                   4913                [OK]                
jenkins/jenkins                        The leading open source automation server       2227                                    
jenkinsci/blueocean                    https://jenkins.io/projects/blueocean           566                                     
jenkinsci/jenkins                      Jenkins Continuous Integration and Delivery …   383                                     
jenkins/jnlp-slave                     a Jenkins agent which can connect to Jenkins…   134 
//....
```



# 选择Jenkins版本

> 推荐使用的Docker映像是 [`jenkinsci/blueocean`映像](https://hub.docker.com/r/jenkinsci/blueocean/) （来自[Docker Hub存储库](https://hub.docker.com/)）。
>
> ----- 摘自《[Jenkins Docs - Installing Jenkins](https://www.jenkins.io/doc/book/installing/)》



### Docker下载Jenkins

```shell
$ docker pull jenkinsci/blueocean     //最新版
```



### 查看Jenkins镜像

```shell
# 查看所有本地主机上的镜像
$ docker images
# 查看镜像元数据
$ docker inspect jenkins镜像ID

# 操作
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
jenkinsci/blueocean   latest            c67eafa3612f        3 hours ago         755MB
centos                latest            0d120b6ccaa8        5 weeks ago         215MB
```



## 二、根据镜像创建Jenkins容器







### 创建一个Jenkins目录

```
$ mkdir /home/docker/jenkins_home
```



创建jenkins文件夹，用于和容器内文件夹做磁盘挂载 ,文件夹授权否则启动时会报没有权限

```
$ sudo chown -R 1000:1000  /home/docker/jenkins_home
```


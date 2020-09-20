[Jenkins，docker实现自动化部署（持续交互）](https://developer.aliyun.com/article/611302)



[Official Jenkins Docker image](https://github.com/jenkinsci/docker)



# Jenkins安装方式

云端部署Jenkins有多种方式：

1. 下载Jenkins包上传到阿里云，手动安装
2. Docker





1、search Jenkins

```
$ docker search jenkins
NAME                                   DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
jenkins                                Official Jenkins Docker image                   4913                [OK]                
jenkins/jenkins                        The leading open source automation server       2227                                    
jenkinsci/blueocean                    https://jenkins.io/projects/blueocean           566                                     
jenkinsci/jenkins                      Jenkins Continuous Integration and Delivery …   383                                     
jenkins/jnlp-slave                     a Jenkins agent which can connect to Jenkins…   134 
//....
```





### Docker下载Jenkins

```
$ docker pull jenkins/jenkins:lts     //最新版
```





### 查看Jenkins镜像

```
$ docker images
$ docker inspect jenkins镜像ID
```



查看镜像

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
jenkins/jenkins     lts                 190554e5446b        9 days ago          708MB
hello-world         latest              bf756fb1ae65        8 months ago        13.3kB
```





### 创建一个Jenkins目录

```
$ mkdir /home/docker/jenkins_home
```



创建jenkins文件夹，用于和容器内文件夹做磁盘挂载 ,文件夹授权否则启动时会报没有权限

```
$ sudo chown -R 1000:1000  /home/docker/jenkins_home
```


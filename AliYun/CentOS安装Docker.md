#CentOS安装Docker

[Dockor官网 - CentOS install Dockor](https://docs.docker.com/engine/install/centos/)

[阿里云官网 - Alibaba Cloud Linux部署并使用Docker](https://help.aliyun.com/document_detail/51853.html?spm=a2c4g.11186623.6.1184.5e022487yfAtAN)



## 1、移除旧版Docker

> 较旧的Docker版本称为`docker`或`docker-engine`；
>
> 现在将Docker Engine软件包称为`docker-ce`。

```
$ sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
```



## 2、Docker安装方式有多种

```
a.大多数用户会 设置Docker的存储库并从中进行安装，以简化安装和升级任务。这是推荐的方法。

b.一些用户下载并手动安装 RPM软件包， 并完全手动管理升级。这在诸如在无法访问互联网的空白系统上安装Docker的情况下非常有用。

c.在测试和开发环境中，一些用户选择使用自动 便利脚本来安装Docker。
```



## 3、使用存储库安装

安装`yum-utils`软件包（提供`yum-config-manager` 实用程序），

并设置**稳定的**存储库。

```
$ sudo yum install -y yum-utils

$ sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
```



## 4、可选项：

启用**每晚**存储库命令：

```
$ sudo yum-config-manager --enable docker-ce-nightly
```

要启用**测试**通道，请运行以下命令：

```
$ sudo yum-config-manager --enable docker-ce-test
```

禁用**夜间**存储库命令：

```
$ sudo yum-config-manager --disable docker-ce-nightly
```



## 5、安装 Docker Engine

安装 **最新版本** 的Docker Engine和容器

```
$ sudo yum install docker-ce docker-ce-cli containerd.io
```



安装 **特定版本** Docker Engine

* 列出并排序您存储库中可用的版本。本示例按版本号（从高到低）对结果进行排序，并被截断：

  ```
  $ yum list docker-ce --showduplicates | sort -r
  ```

* 通过其完全合格的软件包名称安装特定版本，该软件包名称是软件包名称（`docker-ce`）加上版本字符串（第二列），从第一个冒号（`:`）到第一个连字符，以连字符（`-`）分隔。例如，`docker-ce-18.09.1`。

  ```
  $ sudo yum install docker-ce-<VERSION_STRING> docker-ce-cli-<VERSION_STRING> containerd.io
  ```



6、安装最新版本遇到的问题

```
[root@iZbp1hyj00tfq6xxxxxxxx ~]# sudo yum install docker-ce docker-ce-cli containerd.io
Last metadata expiration check: 0:05:53 ago on Sat 19 Sep 2020 12:54:46 AM CST.
Error: 
 Problem: package docker-ce-3:19.03.13-3.el7.x86_64 requires containerd.io >= 1.2.2-3, but none of the providers can be installed
  - cannot install the best candidate for the job
  - package containerd.io-1.2.10-3.2.el7.x86_64 is filtered out by modular filtering
  - package containerd.io-1.2.13-3.1.el7.x86_64 is filtered out by modular filtering
  - package containerd.io-1.2.13-3.2.el7.x86_64 is filtered out by modular filtering
  - package containerd.io-1.2.2-3.3.el7.x86_64 is filtered out by modular filtering
  - package containerd.io-1.2.2-3.el7.x86_64 is filtered out by modular filtering
  - package containerd.io-1.2.4-3.1.el7.x86_64 is filtered out by modular filtering
  - package containerd.io-1.2.5-3.1.el7.x86_64 is filtered out by modular filtering
  - package containerd.io-1.2.6-3.3.el7.x86_64 is filtered out by modular filtering
  - package containerd.io-1.3.7-3.1.el7.x86_64 is filtered out by modular filtering
(try to add '--skip-broken' to skip uninstallable packages or '--nobest' to use not only best candidate packages)
[root@iZbp1hyj00tfq6s5xxxxxx ~]# 
```

【问题】：containerd.io 版本过低

【原因】：最新的 docker-ce 需要安装最新的 containerd.io ，可以查看安装包，应该版本不够。

【解决】：两个方案：降低Docker版本 或 安装最新containerd.io

1. 安装最新的 containerd.io-1.2.6：https://download.docker.com/linux/centos/8/x86_64/stable/Packages/ 

```
$ yum install -y https://download.docker.com/linux/centos/8/x86_64/stable/Packages/containerd.io-1.3.7-3.1.el8.x86_64.rpm
```

2. 再安装剩下两个包

```
$ sudo yum install docker-ce docker-ce-cli
```



## 7、启动Docker

```
$ sudo systemctl start docker
```



## 8、设置Docker为开机自启

```
[root@localhost ~]# sudo systemctl enable docker

Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /usr/lib/systemd/system/docker.service.
```



## 9、验证是否正确安装了Docker Engine

通过运行`hello-world` 映像来验证是否正确安装了Docker Engine 。

```
$ sudo docker run hello-world

// ...
Hello from Docker!
This message shows that your installation appears to be working correctly.
// ...
```



##  10、升级DOCKER引擎

要升级Docker Engine，请按照[安装说明](https://docs.docker.com/engine/install/centos/#install-using-the-repository)，选择要安装的新版本。




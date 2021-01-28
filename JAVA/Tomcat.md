[自建测试服务器(一)MAC+JAVA+IDEA+Tomcat搭建](https://www.jianshu.com/p/b9e628bb02df)

[自建测试服务器(二)Mac下IDEA的使用技巧](https://www.jianshu.com/p/ec0b5d468eea)

[自建测试服务器(三)JavaWeb项目搭建与本地Tomcat部署](https://www.jianshu.com/p/724da8122e88)

[自建测试服务器(四)JavaWeb打war包并模拟部署服务器](https://www.jianshu.com/p/db16aec6c3da)



# 一、TomCat安装

## 1.手动安装

下载地址：[http://tomcat.apache.org](http://tomcat.apache.org/download-80.cgi)

解压缩tomcat到任意目录下（推荐：/usr/local）
进入tomcat的bin目录，使用命令启动tomcat

```shell
#启动tomcat
$ ./startup.sh

#关闭tomcat
$ ./shutdown.sh

#如果没有权限，则修改下权限
$ sudo chmod 755 /Library/apache-tomcat-8.5.16/bin/*.sh

```

## 2.Homebrew 安装 TomCat

[Mac下安装配置Tomcat 9, Homebrew安装Tomcat](https://blog.csdn.net/zgpeace/article/details/104529616)

```shell
#搜索tomcat是否存在：
$ brew search tomcat

#安装tomcat：
$ brew install tomcat
#指定版本9
$ brew install tomcat@9

#检查是否安装成功：
$ catalina -h

#启动
$ catalina start
#停止
$ catalina stop
#运行tomcat（有Log日志）
$ catalina run
```



# 二、日常配置

## 1.更改tomcat端口号

Tomcat的默认端口是8080，如果运行成功可通过[http://localhost:8080](http://localhost:8080)访问

也可以将其改成自定义的端口,为了避免与系统端口冲突,必须设置为1024以上,例如设置为8888。
方法是，用记事本**打开ApacheTomcat的conf目录下的server.xml文件,将以下语句的port值8080改为自定义的端口号:(例如8081)**

```
  <Connector port="8081" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
```



## 2.用户和密码设置

在conf目录的tomcat-users.xml文件里</tomcat-users>上面加入以下代码:

```xml
<role rolename="manager-gui"/>
<user username="tomcat" password="tomcat" roles="manager-gui"/>
---
```

因为xml的标签都要关闭,还要重启tomcat. 重新打开[http://localhost:8080](http://localhost:8080/)到Tomcat主界面,点击 Manager App等按钮账号和密码输入tomcat即可登陆。




















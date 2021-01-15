# Node.JS简介

简单的说 Node.js 就是运行在服务端的 JavaScript。



# Mac OS 上安装

你可以通过以下两种方式在 Mac OS 上来安装 node：

- 1、在[官方下载网站](https://nodejs.org/en/download/)下载 pkg 安装包，直接点击安装即可。

- 2、使用 brew 命令来安装：

  ```shell
  ~ brew install node
  ```



# [npm 使用介绍](https://www.runoob.com/nodejs/nodejs-npm.html)

NPM是随同Node JS一起安装的包管理工具，能解决NodeJS代码部署上的很多问题，常见的使用场景有以下几种：

- 允许用户从NPM服务器下载别人编写的第三方包到本地使用。
- 允许用户从NPM服务器下载并安装别人编写的命令行程序到本地使用。
- 允许用户将自己编写的包或命令行程序上传到NPM服务器供别人使用。

由于新版的nodejs已经集成了npm，所以之前npm也一并安装好了。同样可以通过输入 **"npm -v"** 来测试是否成功安装。命令如下，出现版本提示表示安装成功:

```shell
# 查看
$ npm -v
2.3.0

# 升级npm
$ sudo npm install npm -g

# 使用 npm 命令安装模块
$ npm install <Module Name> 		# 本地安装
$ npm install <Module Name> -g	# 全局安装

# 备注
	#本地安装
1. 将安装包放在 ./node_modules 下（运行 npm 命令时所在的目录），如果没有 node_modules 目录，会在当前执行 npm 命令的目录下生成 node_modules 目录。
2. 可以通过 require() 来引入本地安装的包。
	#全局安装
1. 将安装包放在 /usr/local 下或者你 node 的安装目录。
2. 可以直接在命令行里使用。


```








[Python中from import和import的区别？没有比这更好的回答了](https://www.jianshu.com/p/c63e91ae29f8)



## Python路径问题

Mac系统自带python路径为`／System／Library／Frameworks／Python.framework/Version`

这里可能会有多个python版本，里面Current存放系统当前python版本，进入`Current／bin`，

在终端输入`./python --version`即可查看系统当前python版本

(注：若使用`python --version`命令是查看用户当前python版本而不是系统python版本）

HomeBrew安装python路径为`／usr/local/Cellar/python` 里面存放HomeBrew所安装版本，



```shell
$ which python
$ which python3

$ pip install xxx
$ pip3 install xxx

$ python --version
$ python3 --version
```


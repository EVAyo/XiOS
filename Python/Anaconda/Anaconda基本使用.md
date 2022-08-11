



### 终端更新Anaconda

```bash
$ conda update anaconda
```





* [Anaconda](https://www.anaconda.com)
* [PyCharm](https://www.jetbrains.com/pycharm/download/#section=mac)

## 一、下载Anaconda并安装

![](https://upload-images.jianshu.io/upload_images/1859399-8911afe6d78e38ab.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


安装完成后
### 如果终端无法识别conda命令
原因：环境变量没配置好。`ps：一般Anaconda会自动配置环境变量`

![](https://upload-images.jianshu.io/upload_images/1859399-05c532ed3f0bbe9c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


检查环境变量：`sudo vi ~/.bash_profile`

如果环境变量中没有conda那么要手动添加
示例：
```
# added by Anaconda3 2019.03 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
```

刷新环境变量：`source ~/.bash_profile`

需要 ***重新开启终端***，再查看 `conda list` 命令，发现OK了。


###  无端的在终端前部分出现了（base）字样
凭感觉打开了   ～/.bashrc 文件， 发现如下：

可以发现我们找到了问题的源头，那就是aconda自动加入了命令到 .bashrc中，  在我们打开终端的时候自动 执行了   conda  activate base 命令，

于是乎就有了前面所说的问题。

## 二、Conda基本命令
### 环境管理命令
创建新的python环境：`$ conda create --name myenv`
并且还可以指定python的版本：`$ conda create -n myenv python=3.7`
创建新环境并指定包含的库：`$ conda create -n myenv scipy`
并且还可以指定库的版本：`$ conda create -n myenv scipy=0.15.0`
复制环境：`$ conda create --name myclone --clone myenv`
查看是不是复制成功了：`$ conda info --envs`
激活、进入某个环境：`$ source activate myenv`
退出环境：`$ conda deactivate / $ source deactivate`
删除环境：`$ conda remove --name myenv --all`
查看当前的环境列表`$ conda info --envs  / $ conda env list`

### 包/库管理命令
查看conda版本：`$ conda --version`
更新conda版本：`$ conda update conda / anaconda `
查看都安装了那些依赖库：`$ conda list`
更新所有库 `$ conda update --all`
查看某个环境下安装的库：`$ conda list -n myenv`
查找包：`$ conda search <package>`
安装包：`$ conda install <package>`
安装到指定环境：`$ conda install -n myenv <package>`
更新包：`$ conda update <package>`
删除包：`$ conda remove <package>`


## 三、创建自己的虚拟环境

### 3.1、创建learn虚拟环境 `$ conda create -n learn python=3.7`

![](https://upload-images.jianshu.io/upload_images/1859399-47c43588f3e4484e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 3.2、查看learn环境是否创建成功 `$ conda env list`

base环境就是默认的环境；
learn环境就是我们刚刚创建的环境；

![](https://upload-images.jianshu.io/upload_images/1859399-57f0e5182b88746d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 3.3、启动虚拟环境 `$ conda activate learn`

![](https://upload-images.jianshu.io/upload_images/1859399-19ecf4f23dcac852.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 3.4、关闭虚拟环境 `$ conda deactivate`

![](https://upload-images.jianshu.io/upload_images/1859399-d9313bb102b2f3ad.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


## 四、前往 [PyCharm](https://www.jetbrains.com/pycharm/download/#section=mac) 下载安装即可


![](https://upload-images.jianshu.io/upload_images/1859399-b1f33406c43d471d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


## 五、PyCharm绑定Anaconda中的`默认(base)`的Python解释器

![](https://upload-images.jianshu.io/upload_images/1859399-6ac3e21acbbc285f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1859399-093eff51d758e228.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1859399-7825d976a6ccffe7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1859399-bcfd2d85c85be77d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1859399-96240c0dcdc536cb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


#### 六、PyCharm绑定Anaconda中的`learn虚拟环境(learn)`的Python解释器自建的虚拟环境

![](https://upload-images.jianshu.io/upload_images/1859399-5ebbdd5555c2ae40.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1859399-3fb1a8d4ecee4c0a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



## 七、learn虚拟环境 的hello world

![](https://upload-images.jianshu.io/upload_images/1859399-eb5411377736b235.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![](https://upload-images.jianshu.io/upload_images/1859399-f9507342331c1c1b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/1859399-5df6b148c5b225a8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

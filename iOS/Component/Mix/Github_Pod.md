CocoaPods官网文档

[Making a CocoaPod](https://guides.cocoapods.org/making/making-a-cocoapod.html)

[Using Pod Lib Create](https://guides.cocoapods.org/making/using-pod-lib-create)



# 前期工作

1、Github创建pod仓库



2、 创建本地pod库

```shell
$ pod lib create [pod name]

....
What platform do you want to use?? [ iOS / macOS ]
 > iOS

What language do you want to use?? [ Swift / ObjC ]
 > ObjC

Would you like to include a demo application with your library? [ Yes / No ]
 > Yes

Which testing frameworks will you use? [ Specta / Kiwi / None ]
 > None

Would you like to do view based testing? [ Yes / No ]
 > Yes

What is your class prefix?
 > LX
....
```



3、本地pod仓库关联到远程github仓库

...or create a new repository on the command line

```
echo "# OnlySwiftDemo" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/lionsom/OnlySwiftDemo.git
git push -u origin main
```

…or push an existing repository from the command line

```
git remote add origin https://github.com/lionsom/OnlySwiftDemo.git
git branch -M main
git push -u origin main
```

…or import code from another repository

You can initialize this repository with code from a Subversion, Mercurial, or TFS project.



# 第一类：纯OC组件

```shell
# 本地验证
~ pod lib lint --allow-warnings --sources='https://github.com/CocoaPods/Specs.git' --use-libraries --verbose --no-clean


# 远程验证
~ pod spec lint --allow-warnings --sources='https://github.com/CocoaPods/Specs.git' --use-libraries --verbose --no-clean

# 更新
~ pod repo push LXSpecs OnlyOCDemo.podspec --allow-warnings --use-libraries
```



# 第二类：纯Swift组件





# 第三类：OC组件新增Swift

> 注意：验证移除--use-libraries，podfile使用

```
~ pod lib lint --allow-warnings --sources='https://github.com/lionsom/LXSpecs.git,https://github.com/CocoaPods/Specs.git' --use-libraries --verbose --no-clean

~ pod spec lint --allow-warnings --sources='https://github.com/lionsom/LXSpecs.git,https://github.com/CocoaPods/Specs.git' --use-libraries --verbose --no-clean

pod lib lint --allow-warnings --sources='https://github.com/lionsom/LXSpecs.git,https://github.com/CocoaPods/Specs.git' --verbose --no-clean

pod spec lint --allow-warnings --sources='https://github.com/lionsom/LXSpecs.git,https://github.com/CocoaPods/Specs.git' --verbose --no-clean


pod repo push LXSpecs OCAddSwiftDemo.podspec --allow-warnings --skip-import-validation --sources='https://github.com/lionsom/LXSpecs.git,https://github.com/CocoaPods/Specs.git' --verbose 

pod spec lint --allow-warnings --sources='https://github.com/lionsom/LXSpecs.git,https://github.com/CocoaPods/Specs.git' --verbose --no-clean
```











# 第四类：Swift组件新增OC


















[Swift与OC混编过程中的配置](https://juejin.im/post/5d5a399a6fb9a06af50fca2b)



# 一、OC项目新增Swift



## 1、建立桥接文件

在OC项目中新建Swift文件，会弹出提示，选择 `Create Bridging Header` 建立桥接文件，系统会建立 `“工程名-Bridging-Header.h”`。

![](media_OC&Swift/001.jpg)

![](media_OC&Swift/002.jpg)

![](media_OC&Swift/003.jpg)



## 2、项目配置

首先，在工程的 `Build Settings` 中把 `defines module` 设为 `YES`.

![](media_OC&Swift/004.jpg)



然后，把 `product module name` 设置为**项目工程的名字**。 (系统会自动为我们设置好)

![](media_OC&Swift/005.jpg)



我们再来看一下在这个宿主工程中，OC类中访问Swift，在工程配置的Build Settings中搜索Swift Compiler，可以看到Swift与OC混编的两个配置文件：

![](media_OC&Swift/008.jpg)



**此时系统会为工程创建一个“工程名-Swift.h”的文件(不会显示出来,可以引用)，此文件不可手动创建，必须使用系统创建的** ，此时我们在想要访问Swift方法的OC类中导入ProductName-Swift.h（手动输入没有提示，并且在编译之前报红），然后编译一下，再进入查看源文件：

在想要访问Swift方法的OC类中导入ProductName-Swift.h（手动输入没有提示，并且在编译之前报红），然后编译一下，再进入查看源文件：

![](media_OC&Swift/006.jpg)



![](media_OC&Swift/007.jpg)



## 3、创建Swift类



### 1. OC类调用Swift方法

> 1. Swift类中，凡是允许OC访问的方法，方法前都要加@objc；
> 2. Swift类中用public修饰过的方法，才会出现在ProductName-Swift.h文件中；
> 3. 所有Swift类在ProductName-Swift.h文件都会被自动注册，以会自动@interface修饰，ProductName-Swift.h文件会自动更新。

![](media_OC&Swift/009.jpg)

![](media_OC&Swift/010.jpg)



**调用**

![](media_OC&Swift/011.jpg)



### 2. Swift类调用OC方法

![](media_OC&Swift/012.jpg)



**调用**

![](media_OC&Swift/013.jpg)







## 4、OC添加Swift Pod

Podfile文件如下：

```ruby
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'
source 'http://git.qpaas.com/PaasPods/PaasSpecs.git'    # 组件化索引库


target 'main_OC' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for main_OC
  pod 'QYCH5Module_Swift', '0.1.2'

end
```



**Swift头文件引入**

```swift
@import QYCH5Module_Swift;
```



**调用Swift代码**

```swift
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 调用Swift Pod库
    BaseWKWebViewVC *wkVC = [[BaseWKWebViewVC alloc] init];
    [self presentViewController:wkVC animated:YES completion:nil];
}
```





# 二、纯OC组件

### 组件验证：纯OC

```shell
# 本地验证
~ pod lib lint --allow-warnings --sources='https://github.com/CocoaPods/Specs.git' --use-libraries --verbose --no-clean

# 远程验证
~ pod spec lint --allow-warnings --sources='https://github.com/CocoaPods/Specs.git' --use-libraries --verbose --no-clean

# 更新
~ pod repo push LXSpecs OnlyOCDemo.podspec --allow-warnings --use-libraries
```





# 三、⭐OC组件含Swift 集成到 OC项目

> 参考：QYCH5组件新增 .swift 文件  branch : feature/LXApr_Mix , tag : 0.0.1.T.3



## 1. OC组件含Swift

### 组件验证：OC组件含Swift

```shell
pod lib lint --allow-warnings --sources='https://github.com/lionsom/LXSpecs.git,https://github.com/CocoaPods/Specs.git' --verbose --no-clean

pod spec lint --allow-warnings --sources='https://github.com/lionsom/LXSpecs.git,https://github.com/CocoaPods/Specs.git' --verbose --no-clean

pod repo push LXSpecs OCAddSwiftDemo.podspec --allow-warnings --skip-import-validation --sources='https://github.com/lionsom/LXSpecs.git,https://github.com/CocoaPods/Specs.git' --verbose 
```



## 2. OC组件含Swift集成到OC项目

> 参考：QYCH5集成到启业云，项目分支：feature/LXApr_Mix， QYCH5  tag: 0.0.1.T.3







# 四、⭐纯Swift组件集成到 OC Pod 与 OC项目



## 1. 纯Swift Pod

> 参考：QYCUtility组件

```objective-c
// podspec
s.swift_version = '5.0'

// 导入
import QYCUtility.Swift
```



## 2. OC Pod 依赖 Swift Pod

> 参考：QYCCuteHand组件 依赖 QYCUtility组件

注意点：

```objective-c
1、Example项目工程中新建Swift文件和桥接文件；
2、Example的Podfile 中 必须使用 use_frameworks!
3、.podspec中新增s.swift_version = '5.0'
	 若有静态库，还需新增s.static_framework = true
4、验证时 pod lib lint 不使用 --use-libraries
```



## 3. 含有Swift的OC Pod集成到OC项目中

> 参考：QYCCuteHand集成到启业云

```objective-c
1、OC工程Profile中必须使用 use_frameworks!
2、注意：若OC组件中包含静态库，需要在组件的.podspec中新增 s.static_framework = true

```















# 五、Swift组件新增OC
































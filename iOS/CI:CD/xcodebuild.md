[Xcodebuild从入门到精通](https://www.hualong.me/2018/03/14/Xcodebuild/)



# 一、了解



## 1. 查看手册

```
$ man xcodebuild
```



## 2.命令行工具

xcodebuild是打包在`Command Line Tools`中, `Xcode.app` 依赖 `Command Line Tools`。

`Command Line tools` 会安装在/Library/Developer路径下面。

```
$ xcode-select --install
```



## 3. 查看xcodebuild信息

* 路径

  ```shell
  $ which xcodebuild                                                                                                                     
  /usr/bin/xcodebuild
  ```

* 版本号

  ```shell
  $ xcodebuild -version
  Xcode 11.7
  Build version 11E801a
  ```

* 查看SDK

  ```shell
  $ xcodebuild -showsdks
  iOS SDKs:
  	iOS 13.7                      	-sdk iphoneos13.7
  
  iOS Simulator SDKs:
  	Simulator - iOS 13.7          	-sdk iphonesimulator13.7
  
  macOS SDKs:
  	DriverKit 19.0                	-sdk driverkit.macosx19.0
  	macOS 10.15                   	-sdk macosx10.15
  
  tvOS SDKs:
  	tvOS 13.4                     	-sdk appletvos13.4
  
  tvOS Simulator SDKs:
  	Simulator - tvOS 13.4         	-sdk appletvsimulator13.4
  
  watchOS SDKs:
  	watchOS 6.2                   	-sdk watchos6.2
  
  watchOS Simulator SDKs:
  	Simulator - watchOS 6.2       	-sdk watchsimulator6.2
  ```

* 查看SDK详情

  ```shell
  $ xcodebuild  -version -sdk
  iPhoneOS13.7.sdk - iOS 13.7 (iphoneos13.7)
  SDKVersion: 13.7
  Path: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS13.7.sdk
  PlatformVersion: 13.7
  PlatformPath: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform
  BuildID: 4F2FF4AE-DC5B-11EA-BCFB-7EFECD391977
  ProductBuildVersion: 17H22
  ProductCopyright: 1983-2020 Apple Inc.
  ProductName: iPhone OS
  ProductVersion: 13.7
  //..........
  ```

  

# 二、编译






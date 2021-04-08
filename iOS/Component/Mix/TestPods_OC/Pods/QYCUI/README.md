# QYCUI

[![CI Status](https://img.shields.io/travis/597207909@qq.com/QYCUI.svg?style=flat)](https://travis-ci.org/597207909@qq.com/QYCUI)
[![Version](https://img.shields.io/cocoapods/v/QYCUI.svg?style=flat)](https://cocoapods.org/pods/QYCUI)
[![License](https://img.shields.io/cocoapods/l/QYCUI.svg?style=flat)](https://cocoapods.org/pods/QYCUI)
[![Platform](https://img.shields.io/cocoapods/p/QYCUI.svg?style=flat)](https://cocoapods.org/pods/QYCUI)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

QYCUI is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'QYCUI'
pod 'QYCUI/QYCToast'
```
## Update
```ruby
1.clone（http://git.qpaas.com/PaasPods/QYCUI.git）
2.cd QYCUI and open QYCUI.xcworkspace
3.modify source
4.modify QYCUI.podspec(tag)
5.pod lib lint --allow-warnings --sources='http://git.qpaas.com/PaasPods/PaasSpecs.git,https://github.com/CocoaPods/Specs.git'
6.git add . 并 git commit -m"xxxx"
7.git push
8.git tag xxx
9.git push --tags
10.pod repo push PaasSpecs QYCUI.podspec --allow-warnings --sources='http://git.qpaas.com/PaasPods/PaasSpecs.git,https://github.com/CocoaPods/Specs.git'
```
## Author

597207909@qq.com, 597207909@qq.com

## License

QYCUI is available under the MIT license. See the LICENSE file for more info.





# 版本更新

## V 0.1.6

> 1. WZL小红点颜色修改为 #FF4C4C；



## V 0.1.5

> 1. WZL小红点位置微调；
> 2. 移除SDWebImage 指定版本；



## V 0.1.4

> 1. 新增SDCycleScrollView；
> 2. 新增WZLBadge；



## V 0.1.3

> 1. 新增MBProgressHUD；



## V 0.1.2

> 1. 索引库、代码仓库迁移；



## V 0.1.1

> 1. 对 `QYCToast` 代码进行整理，引入 `QYCToastDefine.h` 文件对解耦代码进行整理；



## V 0.1.0

> 1. 添加 `QYCToast`，并删除其耦合代码；
> 2. 其需要依赖 `'QYCIconFont', '~> 0.1.0'`；






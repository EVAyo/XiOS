# QYCScan

[![CI Status](https://img.shields.io/travis/597207909@qq.com/QYCScan.svg?style=flat)](https://travis-ci.org/597207909@qq.com/QYCScan)
[![Version](https://img.shields.io/cocoapods/v/QYCScan.svg?style=flat)](https://cocoapods.org/pods/QYCScan)
[![License](https://img.shields.io/cocoapods/l/QYCScan.svg?style=flat)](https://cocoapods.org/pods/QYCScan)
[![Platform](https://img.shields.io/cocoapods/p/QYCScan.svg?style=flat)](https://cocoapods.org/pods/QYCScan)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

QYCScan is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'QYCScan'
```
## Update
```ruby
1.clone（http://git.qpaas.com/PaasPods/QYCScan.git）
2.cd QYCScan and open QYCScan.xcworkspace
3.modify source
4.modify QYCScan.podspec(tag)
5.pod lib lint --allow-warnings --sources='http://git.qpaas.com/PaasPods/PaasSpecs.git,https://github.com/CocoaPods/Specs.git'
6.git add . 并 git commit -m"xxxx"
7.git push
8.git tag xxx
9.git push --tags
10.pod repo push PaasSpecs QYCScan.podspec --allow-warnings --sources='http://git.qpaas.com/PaasPods/PaasSpecs.git,https://github.com/CocoaPods/Specs.git'
```
## Use

> 目前仅推荐 Push 弹出扫一扫页面。

## Author

597207909@qq.com, 597207909@qq.com

## License

QYCScan is available under the MIT license. See the LICENSE file for more info.

# 更新说明

## V 0.1.6

```
1. 移除多余注释。
```

## V 0.1.5

```
1. 处理QRView中NSTimer不关闭问题。
```

## V 0.1.4

```
1. 目前推荐push弹出；
2. 返回场景优化。
```

## V 0.1.3

```
1. 不添加具体依赖版本。
```

## V 0.1.2

```
1. 测试依赖不同版本的三方库。
```

## V 0.1.1

```
1. 第二版本；
2. 修复扫描页面退出时机。
```


## V 0.1.0

```
1. 第一版；
2. 支持暗黑；
3. 支持国际化，中文+英文。
```


* [Github - Alamofire](https://github.com/Alamofire/Alamofire)
  * [Alamofire Reference](http://alamofire.github.io/Alamofire/)
  * [Usage](https://github.com/Alamofire/Alamofire/blob/master/Documentation/Usage.md#using-alamofire)
  * [Advanced Usage](https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md)



## 代码行数

查看了一下 `Alamofire` 实现的代码行数：

```shell
# 安装
pod 'Alamofire', '~> 5.0'

# 找到源码路径下
➜ Alamofire git:(main) ✗ find Source -name "*.swift" | xargs cat |wc -l
   13416
```



## PodSpec

```swift
Pod::Spec.new do |s|
  s.name = 'Alamofire'
  s.version = '5.4.1'
  s.license = 'MIT'
  s.summary = 'Elegant HTTP Networking in Swift'
  s.homepage = 'https://github.com/Alamofire/Alamofire'
  s.authors = { 'Alamofire Software Foundation' => 'info@alamofire.org' }
  s.source = { :git => 'https://github.com/Alamofire/Alamofire.git', :tag => s.version }
  s.documentation_url = 'https://alamofire.github.io/Alamofire/'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.swift_versions = ['5.1', '5.2', '5.3']

  s.source_files = 'Source/*.swift'

  s.frameworks = 'CFNetwork'
end
```







## 代码分析

### AFError.swift

```swift
public enum AFError: Error {...}
// Public 权限修饰符
```



```swift
public var asAFError: AFError? {
		self as? AFError
}
/// as? 用法
```



```swift
public func asAFError(orFailWith message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> AFError {
    guard let afError = self as? AFError else {
        fatalError(message(), file: file, line: line)
    }
    return afError
}
// guard 用法 与 if 区别
// @autoclosure 用法
```



```swift
extension Error {...}
// extension 用法
```



```swift
public var urlConvertible: URLConvertible? {
    guard case let .invalidURL(url) = self else { return nil }
    return url
}
// guard case 用法
```

[Pattern Matching, Part 4: if case, guard case, for case](https://alisoftware.github.io/swift/pattern-matching/2016/05/16/pattern-matching-4/)



### Alamofire.swift

```swift
/// Reference to `Session.default` for quick bootstrapping and examples.
public let AF = Session.default

/// Current Alamofire version. Necessary since SPM doesn't use dynamic libraries. Plus this will be more accurate.
let version = "5.4.1"
```

[SPM - swift-package-manager](https://github.com/apple/swift-package-manager)
















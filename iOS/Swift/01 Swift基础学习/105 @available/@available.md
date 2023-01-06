​		Swift 2.0 中，引入了可用性的概念。对于函数，类，协议等，可以使用`@available`声明这些类型的生命周期依赖于特定的平台和操作系统版本。而`#available`用在判断语句中（if, guard, while等），在不同的平台上做不同的逻辑。







@available： 可用来标识计算属性、函数、类、协议、结构体、枚举等类型的生命周期。（依赖于特定的平台版本 或 Swift 版本）。它的后面一般跟至少两个参数，参数之间以逗号隔开。其中第一个参数是固定的，代表着平台和语言，可选值有以下这几个：

iOS
iOSApplicationExtension
macOS
macOSApplicationExtension
watchOS
watchOSApplicationExtension
tvOS
tvOSApplicationExtension
swift

可以使用*指代支持所有这些平台。
有一个我们常用的例子，当需要关闭ScrollView的自动调整inset功能时：



```bash
if #available(iOS 11.0, *) {

  scrollView.contentInsetAdjustmentBehavior = .never

} else {

  automaticallyAdjustsScrollViewInsets = false

}
```

还有一种用法是放在函数、结构体、枚举、类或者协议的前面，表示当前类型仅适用于某一平台：



```swift
@available(iOS 12.0, *)
func adjustDarkMode() {
  /* code */
}
@available(iOS 12.0, *)
struct DarkModeConfig {
  /* code */
}
@available(iOS 12.0, *)
protocol DarkModeTheme {
  /* code */
}
```

版本和平台的限定可以写多个：



```swift
@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
public func applying(_ difference: CollectionDifference<Element>) -> ArraySlice<Element>?
```

注意：作为条件语句的available前面是#，作为标记位时是@
刚才说了，available后面参数至少要有两个，后面的可选参数这些：

deprecated：从指定平台标记为过期，可以指定版本号

obsoleted=版本号：从指定平台某个版本开始废弃（注意弃用的区别，deprecated是还可以继续使用，只不过是不推荐了，obsoleted是调用就会编译错误）该声明
message=信息内容：给出一些附加信息
unavailable：指定平台上是无效的
renamed=新名字：重命名声明

我们看几个例子，这个是Array里flatMap的函数说明：



```swift
@available(swift, deprecated: 4.1, renamed: "compactMap(_:)", message: "Please use compactMap(_:) for the case where closure returns an optional value")
public func flatMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult]
```

它的含义是针对swift语言，该方式在swift4.1版本之后标记为过期，对应该函数的新名字为compactMap(*:)，如果我们在4.1之上的版本使用该函数会收到编译器的警告，即⚠️Please use compactMap(*:) for the case where closure returns an optional value。
在Realm库里，有一个销毁NotificationToken的方法，被标记为unavailable：



```swift
extension RLMNotificationToken {
    @available(*, unavailable, renamed: "invalidate()")
    @nonobjc public func stop() { fatalError() }
}
```

标记为unavailable就不会被编译器联想到。这个主要是为升级用户的迁移做准备，从可用stop()的版本升上了，会红色报错，提示该方法不可用。因为有renamed，编译器会推荐你用invalidate()，点击fix就直接切换了。所以这两个标记参数常一起出现。

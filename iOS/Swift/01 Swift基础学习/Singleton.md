

[Swift **单例**模式讲解和代码示例](https://refactoringguru.cn/design-patterns/singleton/swift/example)

[Swift严格的单例写法](https://www.jianshu.com/p/7c306793f49a)





## Swift 单例

```swift
/// eg1
class Tools {
    // 单例
    public static let shared = Tools()

    // 私有化构造方法，不允许外界创建实例
    private init() {
        // 进行初始化工作
    }
}

/// eg2
class Tools {
    // 单例
    public static let shared = {
    		// ....
      	// ....
      	return Tools()
    }()

    // 私有化构造方法，不允许外界创建实例
    private init() {
        // 进行初始化工作
    }
}

/// 调用
let tools = Tools.shared
```



## 说明

1. 当尝试使用

```swift
let tools = Tools()
```

这种方法去创建一个`Tools`实例时，编译器将会报错，因为我们把`init()`方法私有化了，类外无法通过构造方法创建新实例。

2. `public static let shared = Tools()` 是线程安全的，并且将在第一次调用时进行赋值。

> The lazy initializer for a global variable (also for static members of structs and enums) is run the first time that global is accessed, and is launched as dispatch_once to make sure that the initialization is atomic. This enables a cool way to use dispatch_once in your code: just declare a global variable with an initializer and mark it private.
>
> https://developer.apple.com/swift/blog/?id=7
>
> “全局变量（还有结构体和枚举体的静态成员）的Lazy初始化方法会在其被访问的时候调用一次。类似于调用`dispatch_once`以保证其初始化的原子性。这样就有了一种很酷的`单次调用`方式：只声明一个全局变量和私有的初始化方法即可。”






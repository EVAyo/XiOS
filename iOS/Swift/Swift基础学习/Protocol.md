

[Swift Document -- Protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html)

[Swift中的Protocol知道这些就够了](https://www.jianshu.com/p/ee92fcbb3d21)





# swift中的protocol和OC中protocol的区别

**OC中**

主要是应用到了代理模式中，多用于跨类传值，回调通知，如UITableView的代理

**swift中**

遵守protocol后，可以通过protocol的extension，为遵守protocol的类增加方法。
 (如果两个protocol有相同的方法，那么不能同时遵守两个协议)

**swift中protocol与通过extension为类增加方法的不同：**

通过extension增加的方法是为该类型的所有类增加的方法
 通过协议增加的方法是只为遵守了该协议的类增加的方法

**swift中protocol与继承相比**

遵守了protocol就可以拥有某些功能，而不必去继承自具有该功能的某个类。
 类似其他语言的多继承。



//: [上一页](@previous)
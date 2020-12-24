# 参考文档

* [Why do we use use_frameworks! in CocoaPods?](https://stackoverflow.com/questions/41210249/why-do-we-use-use-frameworks-in-cocoapods)

* [Podfile中的 use_frameworks!](https://segmentfault.com/a/1190000007076865)



`use_frameworks!` tells CocoaPods that you want to use Frameworks instead of Static Libraries. Since Swift does not support Static Libraries you have to use frameworks.

use_frameworks！ 告诉CocoaPods您要使用框架而不是静态库。由于Swift不支持静态库，因此您必须使用框架。

## Cocoa Touch Frameworks

They are always open-source and will be built just like your app. (So Xcode will sometimes compile it, when you run your app and always after you cleaned the project.) Frameworks only support iOS 8 and newer, but you can use Swift and Objective-C in the framework.

它们始终是开源的，并且会像您的应用程序一样构建。 （因此，在您运行应用程序时以及始终在清理项目后，Xcode有时会对其进行编译。）框架仅支持iOS 8和更高版本，但是您可以在框架中使用Swift和Objective-C。

## Cocoa Touch Static Libraries

As the name says, they are static. So they are already compiled, when you import them to your project. You can share them with others without showing them your code. Note that Static Libraries currently don't support Swift. You will have to use Objective-C within the library. The app itself can still be written in Swift.

顾名思义，它们是静态的。 因此，当您将它们导入到项目中时，它们已经被编译。 您可以与其他人共享而不显示他们的代码。 请注意，静态库当前不支持Swift。 您将必须在库中使用Objective-C。 该应用程序本身仍可以用Swift编写。





- if `use_frameworks!` is **present** - `dynamic framework`
  - 如果use_frameworks！ 存在 ----- 动态框架
- if `use_frameworks!` is **not present** - `static library`
  - 如果use_frameworks！ 不存在 ----- 静态库


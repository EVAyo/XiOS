

# Swift 与 Objective-C

* 编程范式

  * Swift可以面向协议编程、函数式编程、面向对象编程。
  * OC以面向对象编程为主，引入ARC库进行函数式编程。

* 类型安全

  * Swift类型安全语言，明确值的类型。
  * OC则不然，我们可以声明NSString变量，运行时仍然可以传递NSNumber给他。

* 值类型增强

  * Swift中，典型的有struct、enum、tuple都是值类型，而平时常用的Int、Double、Float、String、Array、Dictionary、Set 其实都是用 **结构体** 实现的，也是值类型。

  * OC中，NSNumber、NSString以及集合类对象都是指针类型。

* 枚举增强

  * Swift的枚举可以使用 整形、浮点型、字符串等，还能拥有属性和方法，甚至支持泛型、协议、扩展等。
  * OC枚举则鸡肋很多。

* 泛型

  * Swift支持泛型，也支持泛型的类型约束等特性。
  * OC的泛型约束仅仅停留在编译器警告阶段。

* 协议和扩展

  * Swift对协议的支持更丰富，也可以用于值类型。
  * OC协议缺乏强约束，提供optional特性。

* 函数和闭包

  * Swift函数是一等公民，可以定义函数类型变量，可以作为其他函数参数传递，可以作为函数的返回值返回。
  * OC中函数是次等公民，需要selector封装或block才能模拟Swift中类似的效果。



# Swift开发工具

## 1. Swiftc命令行



## 2.REPL交互式解释器

Read Eval PrintLoop



## 3.Playground



# Swift定义常量和变量

* let 声明常量
* var 声明变量



## OC中如何声明常量和变量？

> OC默认声明的都是变量。
>
> 1. `#define`定义常量;
> 2. `static const`定义常量；
> 3. 属性中的 `readonly`;

 

## Swift声明常量和变量

```swift
var wel: String
wel = "hello world"

// 多个变量
var wel = "hello", come = "world", ha = "!"
```



## Swift变量和常量的名字

> 1. Swift变量和常量的名字几乎可以是任何字符，包括Unicode字符；
> 2. 但是名字不能包括 `空白符、数学符号、箭头、保留（或无效）Unicode码、连线、制表符`，不能以`数字开头`。

```
let π = 3.14
let 你好 = "你好世界"
```



## 打印常量和变量

```
print("欢迎\(你好)")

// 欢迎你好世界
```



# Swift中数值类型

## 整数

> Int 拥有与当前平台原生字相同长度
>
> Int8、Int32、Int64
>
> UInt8、UInt32、UInt64

## 浮点数

> Float 32位浮点数
>
> Double【推荐】 64位浮点数



![](media/001.jpg)



## Bool

> 1、true / false
>
> 2、Swift类型安全机制会阻止用一个非布尔量代替Bool

```
【ERROR】
if i==1 {
		print(i)
}
```



## 类型别名 typealias

```
typealias AudioSample = Uint8
let sample: AudioSample
```



# Swift元祖tuple

> 1. tuple可以把多个值合并成一个复合型的值；
> 2. tuple值可以是任何类型，不必是同一类型；

```
let error = (404, "找不到服务")
print(error.0)
print(error.1)

// 1 
// 找不到服务
```



## 可以指定名称

```
let error = (errorCode: 404, errorMessage: "找不到服务")
print(error.errorCode)
print(error.errorMessage)
```



## tuple修改

> 1. `var tuple`为可变元祖，`let tuple`为不可变元祖；
>
> 2. 不管是可变、不可变元祖，元祖创建后就不能增加、删除元素；
> 3. 可变元祖可以对元素进行修改，但不能改变其类型；
> 4. any类型可以改为任何类型；

```
var error: (Any, String)
error.0 = 12
error.1 = "fuck you"

error.1 = "hello"
```



## tuple分解

> 1. 将tuple的内容分解成单独的变量或常量；
> 2. 如果只需要元祖一部分，不需要的数据可以用（_）代替；

```
let error(1, "没有权限", "infomation")
let (errorCode, errorMessage, _) = error
print(errorCode)
print(errorMessage)
```



## 实战 - tuple作为函数返回值

```
func write(content: String) -> (errorCode: Int, errorMessage: String) {
		return (500, "服务器异常")
}

let error = write(content: "哈哈")
print(error)

// (errorCode: 500, errorMessage: "服务器异常")
```



# Swift中使用Optional

## OC中的空值nil

> 1. OC中nil是无类型的指针；
> 2. OC中NSArray、NSDictionary、NSSet等不允许放入nil；
> 3. OC所有对象变量都可以为nil；
> 4. OC中nil只能用在对象上，而其他地方又有其他特殊值（如NSNotFound）表示值的缺失。



## nil在OC与Swift比较

> 1. 在OC中nil是指向一个不存在对象的指针；
> 2. 在Swift中，**nil不是指针**，它是值缺失的一种特殊类型，**「任何类型可选项」**都可以设置成nil。



## Swift引入Optional

> 通过在变量类型后面加 ？表示：
>
> 1. 这里有一个值，它等于x；
> 2. 这里根本没有值。



## Optional使用

### 1. Optional展开

> 1. 可选项是没法直接使用；
> 2. 需要用 ！展开使用；（意思是：我知道这个可选项中有值，展开吧，可以使用）

```
【ERROR】
var str: String? = "abc"
let count = str.count

【Right】
var str: String? = "abc"
if str != nil {
		let count = str.count
}
```

### 2.Optional强制展开

> 使用 ！来获取一个不存在的可选值会导致运行报错，所以在使用！强制展开之前必须确保可选项中包含一个非nil的值。

```
【ERROR】
var str: String?
let count = str!.count
```

### 3.Optional绑定

> 1. 可以使用可选项绑定来判断可选项是否包含值，如果包含就把值赋给一个临时变量或常量；
> 2. 可以与 if 和 while 语句配合使用；
> 3. 同一个if语句中可以包含多个可选项绑定，用逗号隔开，如果其中一个为nil，则整个if判断为false。

```
var str: String? = "abc"
var str1: String? = nil
if let acc = str, let bb = str1 {
		let count = acc.count
}
```

## 4.Optional隐式展开

> 1. 有些可选项一旦被赋值后，就会一直拥有值，这种情况下，就可以去掉检查，不必每次访问都进行展开；
> 2. 通过在声明类型后面加一个叹号（!）而非问号（?）来书写隐式展开；
> 3. 隐身展开可选项主要被用在Swift类初始化过程中；

```
var str: String! = "abc"
let count = str.count
```

## 5.Optional可选链

> 1. 可选项后面加？进行执行；
> 2. 如果可选项不为nil，返回一个可选项结果，可选项结果后续使用依旧需要展开；否则返回nil。

```
var str: String? = "abc"
let count = str?.count      // 这里的count也是一个可选项类型，后续使用也必须进行展开
if count != nil {
		let last = count! - 1
}
```



# Optional实现原理探究







# 字符串String

## 初始化空串

> 1. 字面量
> 2. 初始化器语法
> 3. isEmpty 检测是否为空

```
var str = ""
var str1 = String()

if str.isEmpty {
		// empty
}
```

## 字面量

> Swift会为str常量推断出类型为String

```
let str = "abc"
```

## 多行字面量

> 多行字符串字面量用三个引号

```
let longStr = """
adsadadaajadsjkjkadsjkdask 
akjdsasdkjlasdkjdask
lajklkjdsakjasdkjaskjadskjasdkjda"""
```

## 字符串中特殊字符

> 1. 转义字符：\0（空字符）、 \n（换行符）、\r（回车符）、\t（制表符）；
> 2. Unicode：\u{n}，n为1-8为的十六进制字符且可用的 Unicode 位码。；

```
let str = "\"dsaadsasdf\"ddfaskfkf"
let unicodeStr = "\u{24} \u{1F496}"
```

## 扩展字符串分隔符（Raw String）Swift5新增

> 1. 在字符串字面量中放置扩展字符串分隔符，让字符串中包含的特殊字符不生效；
> 2. 若想让特殊字符生效，转义字符中添加相同数量的#；

```
let str = #"Line 1 \n Line 2"#
// Line 1 \n Line 2

let str1 = #"Line 1 \#n Line 2"#
// Line 1
// Line 2

let str1 = ###"Line 1 \###n Line 2"###
// Line 1
// Line 2
```



# 字符串操作

## 字符串可变性

> var 指定的可修改；
>
> let 指定的不可修改；
>
> 对比OC中的（NSString 和 NSMutableString）

```
var variableString = "Horse"
variableString += " and carriage"
// variableString 现在为 "Horse and carriage"

let constantString = "Highlander"
constantString += " and another Highlander"
// 这会报告一个编译错误（compile-time error） - 常量字符串不可以被修改。
```

## 字符串是值类型

> 1. 在 Swift 中 `String` 类型是*值类型*。
> 2. 如果你创建了一个新的字符串，那么当其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝。
> 3. 在实际编译时，Swift 编译器会优化字符串的使用，使实际的复制只发生在绝对必要的情况下，这意味着你将字符串作为值类型的同时可以获得极高的性能。

## 使用字符

> 1. for-in 循环获取字符串中的字符；
> 2. 可以创建 字符 常量/变量；
> 3. 字符 数组 可以转成 字符串

```
for character in "Dog!🐶" {
    print(character)
}
// D
// o
// g
// !
// 🐶

let exclamationMark: Character = "!"

let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
print(catString)
// 打印输出：“Cat!🐱”
```

## 字符串拼接

> 1. 加运算符 + 
> 2. 加赋值运算符 +=
> 3. String类型append()方法

```
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
// welcome 现在等于 "hello there"

var instruction = "look over"
instruction += string2
// instruction 现在等于 "look over there"

let exclamationMark: Character = "!"
welcome.append(exclamationMark)
// welcome 现在等于 "hello there!"
```

## 字符串插值

> `\()` 类似于 `NSString stringWithFormat ` 方法

```
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// message 是 "3 times 2.5 is 7.5"
```


















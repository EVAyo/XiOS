# 可参考

[类和结构体](https://www.cnswift.org/classes-and-structures#spl)

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



# 结构体

![](media_06Struct&Class/001.png)



## 初始化器

### 自动生成初始化器

> **保证所有成员都有初始值！！！**

![](media_06Struct&Class/002.png)

![](media_06Struct&Class/003.png)



### 自定义初始化器

> **结构体若自定义初始化，则不会自动生成其他初始化器！！！**

![](media_06Struct&Class/004.png)



### 初始化器本质

![](media_06Struct&Class/005.png)

![](media_06Struct&Class/006.png)





# 类



## 初始化器

![](media_06Struct&Class/007.png)



![](media_06Struct&Class/008.png)





# 结构体与类的本质区别

* 初始化器
  * 结构体
    * 会自动生成初始化器，保证每个成员都有初始值
  * 类
    * 若成员有初始化值，则编译器会自动生成无参的初始化器
    * 若成员没有初始化，则编译器不会生成任何初始化器

* 类型
  * 结构体是值类型
  * 类是引用类型

* 内存分布
  * 结构体 在 栈空间
  * 类 在 堆空间



![](media_06Struct&Class/009.png)



## 如何查看结构体与类的内存信息？

```swift
class Size {
    var width = 1
    var height = 2
}
    
struct Point {
    var x = 3
    var y = 4
}

var ptr = malloc(17)
print(malloc_size(ptr))

print("MemoryLayout<Size>.stride", MemoryLayout<Size>.stride)
print("MemoryLayout<Point>.stride", MemoryLayout<Point>.stride)

print("------------------------")

var size = Size()

print(Mems.size(ofRef: size))

print("size变量的地址", Mems.ptr(ofVal: &size))
print("size变量的内存", Mems.memStr(ofVal: &size))

print("size所指向内存的地址", Mems.ptr(ofRef: size))
print("size所指向内存的内容", Mems.memStr(ofRef: size))

print("------------------------")

var point = Point()
print("point变量的地址", Mems.ptr(ofVal: &point))
print("point变量的内存", Mems.memStr(ofVal: &point))
```









**值类型**

> *值类型* 是一种当它被指定到常量或者变量，或者被传递给函数时会被 **拷贝** 的类型。
>
> * 基本类型：整数、浮点数、布尔量、字符串、数组和字典，都是值类型；
>
> * **结构体** 和 **枚举** 都是值类型。
>
> 这意味着你所创建的任何结构体和枚举实例——和实例作为属性所包含的任意值类型——在代码传递中总是被拷贝的。

**引用类型**

> * 类是引用类型
>
> * 闭包是引用类型
>
> 不同于值类型，在*引用类型*被赋值到一个常量，变量或者本身被传递到一个函数的时候它是*不会*被拷贝的。相对于拷贝，这里使用的是同一个对现存实例的引用。

 

## 值类型

![](media_06Struct&Class/010.png)



### 值类型的赋值操作

![](media_06Struct&Class/011.png)



## 引用类型（指针类型）

![](media_06Struct&Class/012.png)



### 引用类型的赋值操作

![](media_06Struct&Class/014.png)



### 创建类的实例对象，内存申请

![](media_06Struct&Class/013.png)



# 值类型、引用类型的let

![](media_06Struct&Class/015.png)



# 嵌套类型

![](media_06Struct&Class/016.png)



# 枚举、结构体、类都可以定义方法

>* 一般把定义在枚举、结构体、类内部的函数，叫做方法
>
>* 方法占用对象的内存么？
>  * 不占用
>  * 方法的本质就是函数
>  * 方法、函数都存放在代码段

![](media_06Struct&Class/017.png)



# 思考

![](media_06Struct&Class/018.png)
























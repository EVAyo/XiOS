//
//  main.swift
//  TestSwift_LX
//
//  Created by 林祥 on 2021/8/13.
//

import Foundation

print("Hello, World!")

typealias Fn = (Int) -> Int
func getFn() -> Fn {
var num = 0
func plus(_ i: Int) -> Int {
num += i
return num
}
return plus
} // 返回的plus和num形成了闭包








/*
class Point {
    var x = 11      // 8
    var b = true    // 1
    var y = 16      // 8
}


var p = Point()

//class是对象类型数据，使用MemoryLayout对class类型计算其内存结果实际上是对其class类型的引用指针进行操作
print(MemoryLayout<Point>.size)      // 8
print(MemoryLayout<Point>.stride)    // 8
print(MemoryLayout<Point>.alignment) // 8

//print(malloc_size(p))
print(Mems.size(ofRef: p))

print("p变量的地址", Mems.ptr(ofVal: &p))
print("p变量的内存的内容", Mems.memStr(ofVal: &p))

print("p所指向内存的地址", Mems.ptr(ofRef: p))
print("p所指向内存的内容", Mems.memStr(ofRef: p))

print(class_getInstanceSize(Point.self))
print(class_getInstanceSize(type(of: p)))

malloc_size(<#T##ptr: UnsafeRawPointer!##UnsafeRawPointer!#>)
*/



//class Size {
//    var w: Int = 0
//    var h: Int = 0
//}
//
//var s2 = Size()
//print("s2: \(Mems.ptr(ofRef: s2))")
//
//s2 = Size()
//print("s2: \(Mems.ptr(ofRef: s2))")


//func test(s: Size) {
//    print("s: \(Mems.ptr(ofRef: s))")
//}
//
//var s2 = Size()
//print("s2: \(Mems.ptr(ofRef: s2))")
//test(s: s2)



/*
struct Size1 {
    var w: Int
    var h: Int
}


var s1 = Size1(w: 10, h: 20)
print("s1: \(Mems.ptr(ofVal: &s1))")

s1 = Size1(w: 20, h: 30)
print("s1: \(Mems.ptr(ofVal: &s1))")

var s2 = s1
print("s2: \(Mems.ptr(ofVal: &s2))")
*/




func testClassAndStruct() {
    class Size {
        var width = 1
        var height = 2
    }
    
    struct Point {
        var x = 3
        var y = 4
    }
    
    // var ptr = malloc(17)
    // print(malloc_size(ptr))
    
    /*
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
     */
}



/*
// 查看自动初始化器与自定义初始化器 汇编区别
func testStruct01() {
    struct Point1 {
        var x: Int
        var y: Int
        init() {
            x = 11
            y = 22
        }
    }
    
    struct Point2 {
        var x: Int = 11
        var y: Int = 22
    }
    
    _ = Point1()
    _ = Point2()
}

testStruct01()


// 查看结构体内存
func testStruct02() {
    struct Point {
        var x: Int = 10     // 8
        var y: Int = 20     // 8
        var b: Bool = true  // 1
    }
    var p = Point()
    print(Mems.memStr(ofVal: &p))
 
 
 print(MemoryLayout<Point>.size)      // 17
 print(MemoryLayout<Point>.stride)    // 24
 print(MemoryLayout<Point>.alignment) // 8
}

testStruct02()

*/


/*
enum TestEnum {
    case test1(String, Int, Bool, String)
    case test2(Int, Int)
    case test3(Int)
    case test4(Bool)
    case test5(String)
    case test6
}

var e = TestEnum.test1("12334", 3, true, "4567")

// 31 32 33 33 34 00 00 00
// 00 00 00 00 00 00 00 E5
// 03 00 00 00 00 00 00 00
// 01 00 00 00 00 00 00 00
// 34 35 36 37 00 00 00 00
// 00 00 00 00 00 00 00 E4

print(Mems.ptr(ofVal: &e))
print(Mems.memStr(ofVal: &e))

// 31 32 33 33 34 00 00 00
// 00 00 00 00 00 00 00 E5
// 03 00 00 00 00 00 00 00
// 01 00 00 00 00 00 00 00
// 00

var e1 = TestEnum.test2(5, 7)

// 05 00 00 00 00 00 00 00
// 07 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 20
// 00 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 00

print(Mems.ptr(ofVal: &e1))
print(Mems.memStr(ofVal: &e1))

// 05 00 00 00 00 00 00 00
// 07 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 00
// 20 00 00 00 00 00 00 00

var e5 = TestEnum.test5("678")

// 36 37 38 00 00 00 00 00
// 00 00 00 00 00 00 00 E3
// 00 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 80
// 00 00 00 00 00 00 00 00
// 00 00 00 00 00 00 00 00


print(Mems.ptr(ofVal: &e5))
print(Mems.memStr(ofVal: &e5))

// 36 37 38 00 00 00 00 00
// 00 00 00 00 00 00 00 E3
// 00 00 00 00 00 00 00 00
// 80 00 00 00 00 00 00 00


print(MemoryLayout<TestEnum>.size)      // 25
print(MemoryLayout<TestEnum>.stride)    // 32
print(MemoryLayout<TestEnum>.alignment) // 8

print(MemoryLayout<String>.stride)  // 16
print(MemoryLayout<Int>.stride)     // 8
print(MemoryLayout<Bool>.stride)    // 1

print("end")
 */

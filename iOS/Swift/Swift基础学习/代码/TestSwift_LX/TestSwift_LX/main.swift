//
//  main.swift
//  TestSwift_LX
//
//  Created by 林祥 on 2021/8/13.
//

import Foundation

print("Hello, World!")


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

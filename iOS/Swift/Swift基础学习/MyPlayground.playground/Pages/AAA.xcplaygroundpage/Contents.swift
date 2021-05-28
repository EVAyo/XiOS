//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)


func 标签语句() {
    outer: for i in 1...4 {
        for k in 1...4 {
            if k == 3 {
                continue outer
            }
            if i == 3 {
                break outer
            }
            print("i == \(i), k == \(k)")
        }
    }
}

标签语句()




/// 这是X【概述】
///
/// 这里是XXXXXXX【详细描述 】
///
/// - Parameters:
///   - v1: 第一个参数
///   - v2: 第二个参数
/// - Returns: 返回值
///
/// - Note:这里是XX【批注】
///
func 函数描述(v1: Int, v2: String) -> Bool {
    
    return true
}


函数描述(v1: 1, v2: "2")


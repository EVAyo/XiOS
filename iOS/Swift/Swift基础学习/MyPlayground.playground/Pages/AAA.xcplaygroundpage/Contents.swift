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

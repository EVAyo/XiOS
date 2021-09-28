//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

func swapValues<T>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}

var i1 = 10
var i2 = 20
swapValues(&i1, &i2)

var d1 = 10.0
var d2 = 20.0
swapValues(&d1, &d2)

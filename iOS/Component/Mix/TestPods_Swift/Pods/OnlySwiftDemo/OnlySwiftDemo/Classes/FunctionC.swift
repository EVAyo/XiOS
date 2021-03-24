//
//  FunctionC.swift
//  OnlySwiftDemo
//
//  Created by 启业云03 on 2021/3/23.
//

import Foundation

public func printSomethingC(_ log: String) {
    print("FunctionC 打印：\(log)")
}

public class SwiftLibC: NSObject {
    
    @objc public func show() {
        
        print("It is right!")
    }
    
    @objc private func hide() {
        
        print("It is error!")
    }

    func printSomething() {
        print("")
    }
}

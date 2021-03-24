//
//  FunctionE.swift
//  SwiftAddOCDemo
//
//  Created by 启业云03 on 2021/3/24.
//

import Foundation
import OnlySwiftDemo

public class SwiftLibE: NSObject {
    @objc public func show(_ log: String) {
        print("FunctionD_Swift 打印：\(log)")
    }
    
    @objc public func show_OC_Source(_ log: String) {
        FunctionF_OC.printSomethingF(log)
    }
    
    @objc public func show_SwiftPod(_ log: String) {
        SwiftLibC().show()
    }
}

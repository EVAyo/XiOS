//
//  ViewController.swift
//  TestPods_Swift
//
//  Created by 启业云03 on 2021/3/23.
//

import UIKit
import OnlyOCDemo
import OnlySwiftDemo

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .orange
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 纯OC组件
        FunctionA.printSomethingA("你大爷！")
        FunctionB.printSomethingB("我二爷！")
        
        // 纯Swift组件
        OnlySwiftDemo.SwiftLibC().show()
    }

}


//
//  ViewController.swift
//  Swift_Test
//
//  Created by 启业云03 on 2021/8/25.
//

import UIKit
import LXScan;

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scanVC = LXScan.QYYScanViewController()
        self .present(scanVC, animated: true, completion: nil)
        
    }

}


//
//  BaseWKWebViewVC.swift
//  LXSwift
//
//  Created by 启业云03 on 2021/1/29.
//  Copyright © 2021 LX. All rights reserved.
//

import UIKit
import WebKit


class BaseWKWebViewVC: UIViewController, WKUIDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView()
        self.view.addSubview(webView)
        webView.backgroundColor = UIColor.orange
        webView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        let url = URL(string: "https://www.baidu.com")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    
}


//
//  WebKitViewController.swift
//  Pocket Chef
//
//  Created by Jaylin Phipps on 12/4/18.
//  Copyright © 2018 Ryan Rottmann. All rights reserved.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressBAr: UIProgressView!
    
    var recipeURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.navigationDelegate = self
        
        self.progressBAr.progress = 0
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(recipeURL)
        getUrlCall()
    }
    
    func getUrlCall(){
        let url: URL = URL(string: recipeURL)!
        let urlRequest: URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressBAr.progress = Float(webView.estimatedProgress)
        }
    }
}

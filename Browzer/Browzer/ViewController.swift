//
//  ViewController.swift
//  Browzer
//
//  Created by kyosukenakashima on 2019/04/11.
//  Copyright © 2019 kyosukenakashima. All rights reserved.
//

import UIKit
import WebKit
//webViewを使うためにimport WebKitを記載

class ViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var webView: WKWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//の文字列をURL型に変換。オプショナル型であるためnillの可能性があるのでifでnillでない場合のみif  let urlでnillでないことが保証される
        if  let url = URL(string: "http://www.google.com") {
            let request = URLRequest(url: url)
//URLRequest型のオブジェクトを作りこのリクエストをWEBVIEWに投げてWEBを表示させる
        webView.load(request)
//           リクエストを渡す
    }
    webView.navigationDelegate = self
}

@IBAction func reloadTapped(sender: UIButton) {
    webView.reload()
}

@IBAction func backTapped(sender: UIButton) {
    webView.goBack()
}

@IBAction func forwardTapped(sender: UIButton) {
    webView.goForward()
}

    
//読み込みと終了を検知
//webView.navigationDelegate = self
//class ViewController: UIViewController, WKNavigationDelegate {
    
func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    print("Start!")
}
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finish!")
    }
}

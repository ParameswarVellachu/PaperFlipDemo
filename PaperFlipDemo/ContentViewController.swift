//
//  ContentViewController.swift
//  PaperFlipDemo
//
//  Created by Parameswaran on 01/08/24.
//

import UIKit
import WebKit

class ContentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    var dataObject: AnyObject?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        webView.loadHTMLString(dataObject as! String,
                               baseURL: NSURL(string: "") as URL?)
    }
    
}

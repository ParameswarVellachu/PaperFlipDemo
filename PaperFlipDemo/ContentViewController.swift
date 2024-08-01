//
//  ContentViewController.swift
//  PaperFlipDemo
//
//  Created by Parameswaran on 01/08/24.
//

import UIKit
import WebKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var textDescription: UITextView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    var dataObject: UserListModel?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        webView.loadHTMLString(dataObject as! String,
//                               baseURL: NSURL(string: "https://www.google.com/") as URL?)
        titleLabel.text = dataObject?.title
        textDescription.text = dataObject?.description
        if let img = dataObject?.image {
            userImage.image = UIImage(named: img)
        }
    }
    
}

//
//  InfoViewController.swift
//  RGB Color Picker
//
//  Created by Emilio Rodriguez on 6/1/20.
//  Copyright © 2020 RWbc Emilio. All rights reserved.
//

import UIKit
import WebKit

class InfoViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    
    var indexValue: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        var urlStr = ""
        if let index = indexValue {
            if index == 0 {
                urlStr = "https://en.wikipedia.org/wiki/RGB_color_model"
            } else {
                urlStr = "https://en.wikipedia.org/wiki/HSL_and_HSV"
            }
        } else {
            urlStr = "https://en.wikipedia.org/wiki/HTTP_404"
        }
        
        let myURL = URL(string: urlStr)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }
    
    
    @IBAction func closePushed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

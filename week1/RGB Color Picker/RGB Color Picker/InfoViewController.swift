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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string: "https://en.wikipedia.org/wiki/RGB_color_model")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }
    
    
    @IBAction func closePushed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

//
//  WebViewController.swift
//  wizQR
//
//  Created by Fernando Martin Garcia Del Angel on 4/17/19.
//  Copyright © 2019 Fernando Martin Garcia Del Angel. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var url = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlreq = URLRequest(url: url!)
        webView.loadRequest(urlreq)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

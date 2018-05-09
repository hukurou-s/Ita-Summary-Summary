//
//  DetailViewController.swift
//  Ita-Summary-Summary
//
//  Created by 石井怜央 on 2018/05/04.
//  Copyright © 2018 LEO. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet var webView: WKWebView!

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    func configureView() {
    // Update the user interface for the detail item.
    if let article = detailArticle {
        if let articleView = webView {
            let articleURL = URL(string: article.url)
            //let articleURL = NSURL(string: "https://google.co.jp")
            let urlRequest = URLRequest(url: articleURL!)
            articleView.load(urlRequest)
        }
    }
    }


    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    configureView()
    }


    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }


    var detailArticle: Article? {
    didSet {
        // Update the view.
        configureView()
    }

    }



}

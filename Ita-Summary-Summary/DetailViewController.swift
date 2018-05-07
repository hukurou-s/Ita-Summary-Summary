//
//  DetailViewController.swift
//  Ita-Summary-Summary
//
//  Created by 石井怜央 on 2018/05/04.
//  Copyright © 2018 LEO. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!



    func configureView() {
    // Update the user interface for the detail item.
    if let detail = detailItem {
        if let label = detailDescriptionLabel {
            label.text = detail.url
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


    var detailItem: Article? {
    didSet {
        // Update the view.
        configureView()
    }

    }



}

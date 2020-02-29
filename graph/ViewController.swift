//
//  ViewController.swift
//  graph
//
//  Created by Admin on 2/28/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var graphView: GraphComponent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let testData = Utils.parseJSon(data: Utils.testData)
        graphView.setEPGData(epgData: testData)
        graphView.recalculateAndRedraw(reset: true)
        
        graphView.delegate = self
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollView.setNeedsDisplay()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.setNeedsDisplay()
    }
}


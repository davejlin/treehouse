//
//  LabelViewController.swift
//  AutoLayoutExamples
//
//  Created by Lin David, US-205 on 10/1/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import UIKit

class LabelViewController: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var labelTrailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        label1.text = "This is very important text"
        
        label2.text = "This is less important text"
        
    }
    
    override func viewWillLayoutSubviews() {
        labelTrailingConstraint.constant = 50
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


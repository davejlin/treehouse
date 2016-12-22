//
//  DepositController.swift
//  VendingMachine
//
//  Created by Lin David, US-205 on 9/19/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

class DepositController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

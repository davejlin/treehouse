//
//  ViewController.swift
//  Fun Facts
//
//  Created by Lin David, US-205 on 9/13/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    let factModel = FactModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mainLabel.text = factModel.getRandomFact()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        let randomColor = ColorModel().getRandomColor()
        view.backgroundColor = randomColor
        button.tintColor = randomColor        
        mainLabel.text = factModel.getRandomFact()
    }
}


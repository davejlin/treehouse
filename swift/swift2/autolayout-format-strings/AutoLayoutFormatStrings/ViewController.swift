//
//  ViewController.swift
//  AutoLayoutFormatStrings
//
//  Created by Lin David, US-205 on 10/3/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let orangeView = UIView()
    let purpleView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        orangeView.backgroundColor = UIColor(red: 255/255.0, green: 148/255.0, blue: 0.0, alpha: 1.0)
        purpleView.backgroundColor = UIColor(red: 187/255.0, green: 44/255.0, blue: 162/255.0, alpha: 1.0)
        blueView.backgroundColor = UIColor(red: 122/255.0, green: 206/255.0, blue: 255/255.0, alpha: 1.0)
        
        orangeView.translatesAutoresizingMaskIntoConstraints = false
        purpleView.translatesAutoresizingMaskIntoConstraints = false
        blueView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(orangeView)
        view.addSubview(purpleView)
        view.addSubview(blueView)
        
        let views: [String: AnyObject] = [
            "orangeView": orangeView,
            "purpleView": purpleView,
            "blueView": blueView,
            "topLayoutGuide": self.topLayoutGuide
        ]
        
        let metrics: [String: AnyObject] = [
            "orangeViewWidth": 200,
            "orangeViewHeight": 57,
            "standardOffset": 8,
            "bottomSpaceOffset": 50
        ]
        
        orangeView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        
        let constraints1 = NSLayoutConstraint.constraintsWithVisualFormat("H:[orangeView(orangeViewWidth)]", options: [], metrics: metrics, views: views)
        
        view.addConstraints(constraints1)
        
        let constraints2 = NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-standardOffset-[purpleView]-standardOffset-[orangeView(orangeViewHeight)]-bottomSpaceOffset-|", options: [], metrics: metrics, views: views)
        
        view.addConstraints(constraints2)
        
        let constraints3 = NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-standardOffset-[blueView]-standardOffset-[orangeView]", options: [], metrics: metrics, views: views)
        
        view.addConstraints(constraints3)

        let constraints4 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-standardOffset-[purpleView(==blueView)]-standardOffset-[blueView]-standardOffset-|", options: [], metrics: metrics, views: views)
        
        view.addConstraints(constraints4)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


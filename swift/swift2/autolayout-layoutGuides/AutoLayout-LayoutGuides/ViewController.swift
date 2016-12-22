//
//  ViewController.swift
//  AutoLayout-LayoutGuides
//
//  Created by Lin David, US-205 on 10/2/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var fourthView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupConstraints() {
        let topLayoutGuide = UILayoutGuide()
        let centerLayoutGuide = UILayoutGuide()
        let bottomLayoutGuide = UILayoutGuide()
        
        view.addLayoutGuide(topLayoutGuide)
        view.addLayoutGuide(centerLayoutGuide)
        view.addLayoutGuide(bottomLayoutGuide)
        
        let firstViewToTopGuideConstraint = NSLayoutConstraint(item: firstView, attribute: .Bottom, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Top, multiplier: 1.0, constant: 0.0)
        
        let secondViewToTopGuideConstraint = NSLayoutConstraint(item: secondView, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        
        let secondViewToBottomGuideConstraint = NSLayoutConstraint(item: secondView, attribute: .Bottom, relatedBy: .Equal, toItem: centerLayoutGuide, attribute: .Top, multiplier: 1.0, constant: 0.0)
        
        let thirdViewToCenterGuideConstraint = NSLayoutConstraint(item: thirdView, attribute: .Top, relatedBy: .Equal, toItem: centerLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        
        let thirdViewToBottomGuideConstraint = NSLayoutConstraint(item: thirdView, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1.0, constant: 0.0)
        
        let fourthViewToBottomGuideConstraint = NSLayoutConstraint(item: fourthView, attribute: .Top, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        
        let topGuideHeightConstraint = NSLayoutConstraint(item: topLayoutGuide, attribute: .Height, relatedBy: .Equal, toItem: centerLayoutGuide, attribute: .Height, multiplier: 1.0, constant: 0.0)
        
        let centerGuideHeightConstraint = NSLayoutConstraint(item: centerLayoutGuide, attribute: .Height, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Height, multiplier: 1.0, constant: 0.0)
        
        view.addConstraints([firstViewToTopGuideConstraint, secondViewToTopGuideConstraint, secondViewToBottomGuideConstraint, thirdViewToCenterGuideConstraint, thirdViewToBottomGuideConstraint, fourthViewToBottomGuideConstraint, topGuideHeightConstraint, centerGuideHeightConstraint])

    }

}


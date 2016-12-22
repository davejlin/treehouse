//
//  PageView.swift
//  ScrollViewTutorial
//
//  Created by Lin David, US-205 on 11/6/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import UIKit

class PageView: UIView {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    class func loadFromNib() -> PageView {
        let bundle = NSBundle(forClass: self)
        let nib = UINib(nibName: "PageView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! PageView
        return view
    }
    
    func configure(data: [String: String]) {
        label.text = data["title"]
        let image = UIImage(named: data["image"]!)
        imageView.image = image
    }
}

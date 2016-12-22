//
//  PhotoCell.swift
//  SelfiePhoto
//
//  Created by Lin David, US-205 on 11/14/16.
//  Copyright © 2016 Lin David. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    static let reuseIdentifier = "\(PhotoCell.self)"
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activateConstraints([
            imageView.leftAnchor.constraintEqualToAnchor(contentView.leftAnchor),
            imageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor),
            imageView.rightAnchor.constraintEqualToAnchor(contentView.rightAnchor),
            imageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor),
        ])
    }
}

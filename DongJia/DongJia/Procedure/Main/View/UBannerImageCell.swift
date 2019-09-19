//
//  UBannerImageCell.swift
//  ZKCycleScrollViewDemo
//
//  Created by bestdew on 2019/3/8.
//  Copyright © 2019 bestdew. All rights reserved.
//

import UIKit

class UBannerImageCell: UBaseCollectionViewCell {

    private var imageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 4
    }
    
    var imageUrl: String? {
        didSet {
            guard let URL = URL(string: imageUrl!) else { return }
            imageView.kf.setImage(with: URL, placeholder: nil, options: [.transition(.fade(0.2))])
        }
    }
    
    override func configUI() {
        imageView.frame = bounds
        contentView.addSubview(imageView)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if imageView.frame.contains(point) {
            return super.hitTest(point, with: event)
        }
        return nil
    }
}

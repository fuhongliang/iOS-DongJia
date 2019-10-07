//
//  UPicCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/27.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UPicCell: UBaseCollectionViewCell {
    private var imageView = UIImageView().then {
        $0.backgroundColor = .white
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

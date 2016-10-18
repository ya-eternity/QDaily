//
//  ZWCarouselCell.swift
//  QDaily
//
//  Created by bmxd-002 on 16/8/12.
//  Copyright © 2016年 Zoey. All rights reserved.
//

import UIKit
import SnapKit

class ZWCarouselCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    var titleLabel: UILabel?
    var titleEdgeInset: UIEdgeInsets?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    deinit {
        print("ZWCarouselCell")
    }
    
    func setupSubviews() {
    
        imageView = UIImageView.init()
        imageView?.contentMode = UIViewContentMode.scaleAspectFill
        imageView?.clipsToBounds = true
        self.contentView.addSubview(imageView!)
        
        imageView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        titleLabel = UILabel.init()
        titleLabel?.backgroundColor = UIColor.clear
        titleLabel?.textColor = UIColor.white
        titleLabel?.textAlignment = NSTextAlignment.left
        titleLabel?.numberOfLines = 0
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.contentView.addSubview(titleLabel!)
        
        titleLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(30)
        })
    }
    
    
}

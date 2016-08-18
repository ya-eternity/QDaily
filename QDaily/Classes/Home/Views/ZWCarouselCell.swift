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
        imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        self.contentView.addSubview(imageView!)
        
        imageView?.snp_makeConstraints(closure: { (make) in
            make.edges.equalToSuperview()
        })
        
        titleLabel = UILabel.init()
        titleLabel?.backgroundColor = UIColor.clearColor()
        titleLabel?.textColor = UIColor.whiteColor()
        titleLabel?.textAlignment = NSTextAlignment.Left
        titleLabel?.numberOfLines = 0
        titleLabel?.font = UIFont.boldSystemFontOfSize(20)
        self.contentView.addSubview(titleLabel!)
        
        titleLabel?.snp_makeConstraints(closure: { (make) in
            make.bottom.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(30)
        })
    }
    
    
}

//
//  ZWCarouselView.swift
//  QDaily
//
//  Created by bmxd-002 on 16/8/12.
//  Copyright © 2016年 Zoey. All rights reserved.
//

import UIKit
import AlamofireImage

class ZWCarouselView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    var imageUrls: Array<String>?
    var titles: Array<String>?
    

    var contentView: UICollectionView?
    var pageControl: UIPageControl?
    
    private let ZWCarouselCellReusedId = "ZWCarouselCell";
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupMainView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupMainView() {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = self.bounds.size;
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        self.contentView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        self.contentView?.delegate = self
        self.contentView?.dataSource = self
        self.contentView?.registerClass(ZWCarouselCell.self, forCellWithReuseIdentifier: ZWCarouselCellReusedId)
        
        self.addSubview(contentView!)
    }
    
// Mark: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (imageUrls?.count)! + 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: ZWCarouselCell = collectionView.dequeueReusableCellWithReuseIdentifier(ZWCarouselCellReusedId, forIndexPath: indexPath) as! ZWCarouselCell
        
        cell.imageView?.af_setImageWithURL(NSURL(string: imageUrls![indexPath.row])!)
        cell.titleLabel?.text = titles![indexPath.row]
        
        return cell
    }
}

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

    var imageUrls: Array<String> = [] {
        didSet {
            contentView.contentOffset = CGPointMake(contentView.frame.size.width, 0)
        }
    }
    var titles: Array<String> = []
    
    var currentIndex = 0
    var timeInterval = 3.0
    
    
    private let ZWCarouselCellReusedId = "ZWCarouselCell";
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(self.contentView)
        
        self.addSubview(self.pageControl)
        self.pageControl.snp_makeConstraints { (make) in
            make.size.equalTo(self.pageControl.sizeForNumberOfPages(self.pageControl.numberOfPages))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        self.timer.fireDate = NSDate(timeInterval: timeInterval, sinceDate: NSDate())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func timerUpdate() {
        currentIndex += 1
        if currentIndex >= self.pageControl.numberOfPages {
            currentIndex = 0;
            contentView.setContentOffset(CGPointMake(0, 0), animated: false)
        }
        self.pageControl.currentPage = currentIndex
        self.contentView.setContentOffset(CGPointMake((CGFloat(currentIndex) + 1) * contentView.frame.size.width, 0), animated: true)
    }
    
// MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard imageUrls.count > 0 else {
            return 0
        }
        return imageUrls.count + 2
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: ZWCarouselCell = collectionView.dequeueReusableCellWithReuseIdentifier(ZWCarouselCellReusedId, forIndexPath: indexPath) as! ZWCarouselCell
        
        var index = indexPath.row - 1 < 0 ? imageUrls.count - 1 : indexPath.row - 1
        if index >= imageUrls.count {
            index = 0
        }
        
        if index < imageUrls.count {
            cell.imageView?.af_setImageWithURL(NSURL(string: imageUrls[index])!)
        }
        if index < titles.count {
            cell.titleLabel?.text = titles[index]
        }
        return cell
    }
    
//    MARK: UIScrollViewDelegate
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.timer.fireDate = NSDate.distantFuture()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / scrollView.bounds.size.width) - 1
        if currentIndex < 0 {
            currentIndex = imageUrls.count - 1
        } else if currentIndex >= imageUrls.count {
            currentIndex = 0
        }
        
        self.pageControl.currentPage = currentIndex
        scrollView.setContentOffset(CGPointMake((CGFloat(currentIndex) + 1) * contentView.frame.size.width, 0), animated: false)
        self.timer.fireDate = NSDate(timeInterval: timeInterval, sinceDate: NSDate())
    }
    
//    MARK: - Setter and Getter
    lazy var contentView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = self.bounds.size;
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        let contentView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        contentView.delegate = self
        contentView.dataSource = self
        contentView.pagingEnabled = true
        contentView.showsHorizontalScrollIndicator = false
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.registerClass(ZWCarouselCell.self, forCellWithReuseIdentifier: self.ZWCarouselCellReusedId)
        
        return contentView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl.init()
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.currentPageIndicatorTintColor = UIColor(red:0.99, green:0.75, blue:0.22, alpha:1.00)
        pageControl.currentPage = self.currentIndex
        
        return pageControl
    }()
    
    private lazy var timer: NSTimer = {
        let timer = NSTimer.scheduledTimerWithTimeInterval(self.timeInterval, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        return timer
    }()
}

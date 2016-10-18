//
//  ZWCarouselView.swift
//  QDaily
//
//  Created by bmxd-002 on 16/8/12.
//  Copyright © 2016年 Zoey. All rights reserved.
//

import UIKit
import AlamofireImage


@objc protocol ZWCarouselViewDelegate: class {
    
    @objc optional func carouselView(_ carouselView: ZWCarouselView, didClickedIndex index: Int)
    
}


class ZWCarouselView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    var imageUrls: Array<String> = [] {
        didSet {
            self.pageControl.numberOfPages = imageUrls.count
            contentView.contentOffset = CGPoint(x: contentView.frame.size.width, y: 0)
            
        }
    }
    var titles: Array<String> = []
    
    var timer: Timer?
    var currentIndex = 0
    weak var delegate: ZWCarouselViewDelegate?
    
    let timeInterval = 5.0
    fileprivate let ZWCarouselCellReusedId = "ZWCarouselCell";
    
    
    var alercell: ZWCarouselCell?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.contentView)
        self.addSubview(self.pageControl)
        
        self.pageControl.snp.makeConstraints {(make) in
            make.size.equalTo(self.pageControl.size(forNumberOfPages: self.pageControl.numberOfPages))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("轮播deinit")
    }
    
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard let _ = newSuperview else {
            self.invalidateTimer()
            return
        }
        self.sutupTimer()
    }
    
    
    func sutupTimer() {
        timer = Timer.scheduledTimer(timeInterval: self.timeInterval, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
        timer!.fireDate = Date(timeInterval: timeInterval, since: Date())
    }
    
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func timerUpdate() {
        currentIndex += 1
        if currentIndex >= self.pageControl.numberOfPages {
            currentIndex = 0;
            contentView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
        self.pageControl.currentPage = currentIndex
        self.contentView.setContentOffset(CGPoint(x: (CGFloat(currentIndex) + 1) * contentView.frame.size.width, y: 0), animated: true)
    }
    
// MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard imageUrls.count > 0 else {
            return 0
        }
        return imageUrls.count + 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ZWCarouselCell = collectionView.dequeueReusableCell(withReuseIdentifier: ZWCarouselCellReusedId, for: indexPath) as! ZWCarouselCell
        
        var index = (indexPath as NSIndexPath).row - 1 < 0 ? imageUrls.count - 1 : (indexPath as NSIndexPath).row - 1
        if index >= imageUrls.count {
            index = 0
        }
        
        if index < imageUrls.count {
            cell.imageView?.af_setImage(withURL: URL(string: imageUrls[index])!)
        }
        if index < titles.count {
            cell.titleLabel?.text = titles[index]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let _delegate = delegate {
            _delegate.carouselView?(self, didClickedIndex: currentIndex);
        }
    }
    
//    MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / scrollView.bounds.size.width) - 1
        if currentIndex < 0 {
            currentIndex = imageUrls.count - 1
        } else if currentIndex >= imageUrls.count {
            currentIndex = 0
        }
        
        self.pageControl.currentPage = currentIndex
        scrollView.setContentOffset(CGPoint(x: (CGFloat(currentIndex) + 1) * contentView.frame.size.width, y: 0), animated: false)
    }
    
//    MARK: - Setter and Getter
    lazy var contentView: UICollectionView = {
//        [unowned self] in
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = self.bounds.size;
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let contentView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        contentView.delegate = self
        contentView.dataSource = self
        contentView.isPagingEnabled = true
        contentView.showsHorizontalScrollIndicator = false
        contentView.backgroundColor = UIColor.white
        contentView.register(ZWCarouselCell.self, forCellWithReuseIdentifier: self.ZWCarouselCellReusedId)
        
        return contentView
    }()
    
    lazy var pageControl: UIPageControl = {
//        [unowned self] in
        let pageControl = UIPageControl.init()
        pageControl.numberOfPages = 0
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor(red:0.99, green:0.75, blue:0.22, alpha:1.00)
        pageControl.currentPage = self.currentIndex
        
        return pageControl
    }()
    
}

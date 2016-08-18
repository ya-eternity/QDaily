//
//  MainViewController.swift
//  QDaily
//
//  Created by ZoeyWang on 16/7/9.
//  Copyright © 2016年 Zoey. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum QDailyCellType: Int {
    case Institute
    case CommenFeed
    case FeedTwo
}


let HOME_URL = "http://app3.qdaily.com/app3/homes/index/0.json?"
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ZWCarouselViewDelegate {
    
    let HomeInstituteCellReusedId = "HomeInstituteCell"
    let HomeFeedCellReusedId = "HomeFeedCell"
    let FeedTypeTwoCellReuseId = "FeedTypeTwoCell"

    
    var banners: Array<HomeModel>?
    var feeds: Array<HomeModel>?
    
    deinit {
        print("deinit self")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    
//  MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        
        self.getData()
        self.view.addSubview(self.tableView)
        self.tableView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.bannerView.delegate = self;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    func getData() {
        Alamofire.request(.GET, HOME_URL).responseJSON {[unowned self] (response) in
            guard response.result.isSuccess else {
                print("request error! \(response.result)")
                return
            }
            let jsonDict = JSON(data: response.data!)
//            print(jsonDict)
            self.banners = HomeModel.modelArray(fromArray: jsonDict["response"]["banners"].arrayObject)
            self.feeds = HomeModel.modelArray(fromArray: jsonDict["response"]["feeds"].arrayObject)
            print(self.feeds)
            for i in 0 ..< (self.banners?.count)! {
                let model = self.banners![i]
                self.bannerView.imageUrls.append(model.image!)
                self.bannerView.titles.append(model.title!)
            }
            self.bannerView.contentView.reloadData()
            self.tableView.reloadData()
        }
    }

    
//  MARK: - UITableViewDelegate and Datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = feeds else {
            return 0
        }
        return (feeds?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let model = self.feeds![indexPath.row]
        switch model.type! {
        case QDailyCellType.Institute.rawValue:
            let cell:HomeInstituteCell = tableView.dequeueReusableCellWithIdentifier(HomeInstituteCellReusedId, forIndexPath: indexPath) as! HomeInstituteCell
            cell.configure(withModel: model)
            return cell
        default:
            break
        }
        return UITableViewCell.init()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = self.feeds![indexPath.row]
        switch model.type! {
        case QDailyCellType.Institute.rawValue:
            let cell:HomeInstituteCell = tableView.dequeueReusableCellWithIdentifier(HomeInstituteCellReusedId) as! HomeInstituteCell
            cell.setNeedsUpdateConstraints()
            cell.updateFocusIfNeeded()
            cell.configure(withModel: model)
            return CGRectGetMaxY(cell.separatorView.frame)
        default:
            break
        }
        return 0
    }
    
//   MARK: - ZWCarouselViewDelegate
    func carouselView(carouselView: ZWCarouselView, didClickedIndex index: Int) {
        print(index)
        UIApplication.sharedApplication().keyWindow?.rootViewController = MainViewController()
    }
    
//   MARK: - setter and getter
    private lazy var tableView: UITableView = {
        [unowned self] in
        let tableView = UITableView.init()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableHeaderView = self.bannerView
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNib(UINib.init(nibName: self.HomeInstituteCellReusedId, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: self.HomeInstituteCellReusedId)
        tableView.registerNib(UINib.init(nibName: self.HomeInstituteCellReusedId, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: self.HomeInstituteCellReusedId)
        tableView.registerNib(UINib.init(nibName: self.HomeInstituteCellReusedId, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: self.HomeInstituteCellReusedId)
        return tableView
    }()
    
    private lazy var bannerView: ZWCarouselView = {
        let bannerView = ZWCarouselView.init(frame: CGRect.init(origin: CGPointZero, size: CGSize.init(width: SCREEN_WIDTH, height: SCREEN_WIDTH * 0.8)))
        return bannerView
    }()

}

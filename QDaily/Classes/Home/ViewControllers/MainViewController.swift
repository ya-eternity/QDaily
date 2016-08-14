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


let HOME_URL = "http://app3.qdaily.com/app3/homes/index/0.json?"
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var banners: Array<HomeModel>?
    
    var feeds: Array<HomeModel>?
    
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
    }
    
    func getData() {
        Alamofire.request(.GET, HOME_URL).responseJSON { (response) in
            guard response.result.isSuccess else {
                print("request error! \(response.result)")
                return
            }
            let jsonDict = JSON(data: response.data!)
            print(jsonDict)
            self.banners = HomeModel.modelArray(fromArray: jsonDict["response"]["banners"].arrayObject)
            for i in 0 ..< (self.banners?.count)! {
                let model = self.banners![i]
                self.bannerView.imageUrls.append(model.image!)
                self.bannerView.titles.append(model.title!)
            }
            self.bannerView.contentView.reloadData()
            print(self.banners)
        }
    }
    
//  MARK: - UITableViewDelegate and Datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (feeds?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    
//   MARK: - setter and getter
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableHeaderView = self.bannerView
        
        return tableView
    }()
    
    private lazy var bannerView: ZWCarouselView = {
        let bannerView = ZWCarouselView.init(frame: CGRect.init(origin: CGPointZero, size: CGSize.init(width: SCREEN_WIDTH, height: SCREEN_WIDTH * 0.8)))
        return bannerView
    }()
}

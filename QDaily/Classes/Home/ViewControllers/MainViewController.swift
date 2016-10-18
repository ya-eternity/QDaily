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
    case institute
    case commenFeed
    case feedTwo
}


let HOME_URL = "http://app3.qdaily.com/app3/homes/index/0.json?"
let SCREEN_WIDTH = UIScreen.main.bounds.size.width


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ZWCarouselViewDelegate {
    
    let HomeInstituteCellReusedId = "HomeInstituteCell"
    let HomeFeedCellReusedId = "HomeFeedCell"
    let FeedTypeTwoCellReuseId = "FeedTypeTwoCell"

    
    var banners: Array<HomeModel>?
    var feeds: Array<HomeModel>?
    
    deinit {
        print("deinit self")
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    
//  MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        
        self.getData()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.bannerView.delegate = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    func getData() {
        Alamofire.request(HOME_URL).responseJSON {[unowned self] (response) in
            guard response.result.isSuccess else {
                print("request error! \(response.result)")
                return
            }
            let jsonDict = JSON(data: response.data!)
//            print(jsonDict)
            self.banners = HomeModel.modelArray(fromArray: jsonDict["response"]["banners"].arrayObject as Array<AnyObject>?)
            self.feeds = HomeModel.modelArray(fromArray: jsonDict["response"]["feeds"].arrayObject as Array<AnyObject>?)
//            print(self.feeds)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = feeds else {
            return 0
        }
        return (feeds?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.feeds![(indexPath as NSIndexPath).row]
        switch model.type! {
        case QDailyCellType.institute.rawValue:
            let cell: HomeInstituteCell = tableView.dequeueReusableCell(withIdentifier: HomeInstituteCellReusedId, for: indexPath) as! HomeInstituteCell
            cell.configure(withModel: model)
            return cell
        case QDailyCellType.commenFeed.rawValue:
            let cell: HomeFeedCell = tableView.dequeueReusableCell(withIdentifier: HomeFeedCellReusedId, for: indexPath) as! HomeFeedCell
            cell.configure(withModel: model)
            return cell
        case QDailyCellType.feedTwo.rawValue:
            let cell: FeedTypeTwoCell = tableView.dequeueReusableCell(withIdentifier: FeedTypeTwoCellReuseId, for: indexPath) as! FeedTypeTwoCell
            cell.configure(withModel: model)
            return cell
        default:
            break
        }
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = self.feeds![(indexPath as NSIndexPath).row]
        switch model.type! {
        case QDailyCellType.institute.rawValue:
            let cell:HomeInstituteCell = tableView.dequeueReusableCell(withIdentifier: HomeInstituteCellReusedId) as! HomeInstituteCell
            cell.configure(withModel: model)
            return cell.maxY
            
        case QDailyCellType.commenFeed.rawValue:
            return 130
        case QDailyCellType.feedTwo.rawValue:
            let cell: FeedTypeTwoCell = tableView.dequeueReusableCell(withIdentifier: FeedTypeTwoCellReuseId) as! FeedTypeTwoCell
            cell.configure(withModel: model)
            return cell.maxY
        default:
            break
        }
        return 0
    }
    
//   MARK: - ZWCarouselViewDelegate
    func carouselView(_ carouselView: ZWCarouselView, didClickedIndex index: Int) {
        print(index)
    }
    
//   MARK: - setter and getter
    fileprivate lazy var tableView: UITableView = {
        [unowned self] in
        let tableView = UITableView.init()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.tableHeaderView = self.bannerView
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: self.HomeInstituteCellReusedId, bundle: Bundle.main), forCellReuseIdentifier: self.HomeInstituteCellReusedId)
        tableView.register(UINib.init(nibName: self.HomeFeedCellReusedId, bundle: Bundle.main), forCellReuseIdentifier: self.HomeFeedCellReusedId)
        tableView.register(UINib.init(nibName: self.FeedTypeTwoCellReuseId, bundle: Bundle.main), forCellReuseIdentifier: self.FeedTypeTwoCellReuseId)
        return tableView
    }()
    
    fileprivate lazy var bannerView: ZWCarouselView = {
        let bannerView = ZWCarouselView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: SCREEN_WIDTH, height: SCREEN_WIDTH * 0.8)))
        return bannerView
    }()

}

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

class MainViewController: UIViewController {
    
    var banners: Array<HomeModel>?
    
    var feeds: Array<HomeModel>?
    
    
//MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        
        self.getData()
    
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
            print(self.banners)
        }
    }

}

//
//  HomeModel.swift
//  QDaily
//
//  Created by bmxd-002 on 16/8/8.
//  Copyright © 2016年 Zoey. All rights reserved.
//

import UIKit

class HomeModel: NSObject {
    
    var image: String?
    var type: Int?
    var id: String?
    var genre: Int?
    var title: String?
    var desc: String?
    var publishTime: String?
    var commentCount: Int?
    var praiseCount: Int?
    var superTag: String?
    var pageStyle: Int?
    var postId: String?
    var appview: String?
    var datatype: String?
    var categoryId: Int?
    var categoryTitle: String?
    var categoryImage: String?
    var columnIcon: String?
    var columnName: String?
    
    convenience init(dictionary: NSDictionary) {
        self.init()
        self.image = dictionary["image"] as? String
        self.type = dictionary["type"] as? Int
        
        let dict = dictionary["post"] as! NSDictionary
        self.id = dict["id"] as? String
        self.genre = dict["genre"] as? Int
        self.title = dict["title"] as? String
        self.desc = dict["description"] as? String
        self.publishTime = dict["publish_time"] as? String
        self.commentCount = dict["comment_count"] as? Int
        self.praiseCount = dict["praise_count"] as? Int
        self.superTag = dict["super_tag"] as? String
        self.pageStyle = dict["page_style"] as? Int
        self.postId = dict["post_id"] as? String
        self.appview = dict["appview"] as? String
        self.datatype = dict["datatype"] as? String
        self.categoryId = dict["category"]!["id"] as? Int
        self.categoryTitle = dict["category"]!["title"] as? String
        self.categoryImage = dict["category"]!["normal"] as? String
        
        if let column = dict["column"] {
            self.columnIcon = column["icon"] as? String
            self.columnName = column["name"] as? String

        }
        
    }
    
    static func modelArray(fromArray fromArray: Array<AnyObject>?) -> Array<HomeModel>? {
        guard let array = fromArray else {
            return nil;
        }
        var models: Array<HomeModel>? = Array()
        for dic in array {
            let model = HomeModel(dictionary: dic as! NSDictionary)
            models?.append(model)
        }
        
        return models;
    }
    
}

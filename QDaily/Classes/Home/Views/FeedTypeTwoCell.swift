//
//  FeedTypeTwoCell.swift
//  QDaily
//
//  Created by bmxd-002 on 16/8/17.
//  Copyright © 2016年 Zoey. All rights reserved.
//

import UIKit

class FeedTypeTwoCell: UITableViewCell {
    
    
    @IBOutlet weak var subjectImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var praiseCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentIcon: UIImageView!
    @IBOutlet weak var praiseIcon: UIImageView!

    var maxY: CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(withModel model: HomeModel) {

        subjectImageView.af_setImage(withURL: URL.init(string: model.image!)!)
        titleLabel.text = model.title!
        detailLabel.text = model.desc!
        category.text = model.categoryTitle
        praiseCount.text =  String(model.praiseCount!)
        commentCount.text =  String(model.commentCount!)
        timeLabel.text = model.publishTimeString;
        
        let screenWidth = UIScreen.main.bounds.size.width
        maxY = screenWidth / 15.0 * 8 + 66 + ZWUtils().heightForString(titleLabel.text!, withFont: titleLabel.font, width: screenWidth - 28) + ZWUtils().heightForString(detailLabel.text!, withFont: detailLabel.font, width: screenWidth - 28)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  HomeTypeZeroCell.swift
//  QDaily
//
//  Created by bmxd-002 on 16/8/17.
//  Copyright © 2016年 Zoey. All rights reserved.
//

import UIKit

class HomeInstituteCell: UITableViewCell {

    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subjectImageView: UIImageView!
    @IBOutlet weak var subjectTitle: UILabel!
    @IBOutlet weak var subjectDetail: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var categoryIcon: UIImageView!
    
    
    var maxY: CGFloat = 0.0
    
    
    @IBAction func shareClick(_ sender: UIButton) {
        
        
    }
    
    
    func configure(withModel model: HomeModel) {
        iconImageView.af_setImage(withURL: URL.init(string: model.columnIcon!)!)
        titleLabel.text = model.columnName!
        subjectImageView.af_setImage(withURL: URL.init(string: model.image!)!)
        subjectTitle.text = model.title!
        subjectDetail.text = model.desc!
        categoryIcon.af_setImage(withURL: URL.init(string:model.categoryImage!)!)
        let screenWidth = UIScreen.main.bounds.size.width
        maxY = screenWidth / 15.0 * 8 + 88 + ZWUtils().heightForString(subjectTitle.text!, withFont: subjectTitle.font, width: screenWidth - 28) + ZWUtils().heightForString(subjectDetail.text!, withFont: subjectDetail.font, width: screenWidth - 28)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

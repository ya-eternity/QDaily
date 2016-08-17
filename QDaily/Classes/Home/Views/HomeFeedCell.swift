//
//  HomeFeedCell.swift
//  QDaily
//
//  Created by bmxd-002 on 16/8/17.
//  Copyright © 2016年 Zoey. All rights reserved.
//

import UIKit

class HomeFeedCell: UITableViewCell {

    @IBOutlet weak var subjectImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var praiseCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentIcon: UIImageView!
    @IBOutlet weak var praiseIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

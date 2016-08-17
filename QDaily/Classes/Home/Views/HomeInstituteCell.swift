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
    
    
    @IBAction func shareClick(sender: UIButton) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

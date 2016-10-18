//
//  ZWUtils.swift
//  QDaily
//
//  Created by bmxd-002 on 16/9/1.
//  Copyright © 2016年 Zoey. All rights reserved.
//

import UIKit

class ZWUtils {

    func heightForString(_ string: String, withFont font: UIFont, width: CGFloat) -> CGFloat {
        return string.boundingRect(
            with: CGSize(width: width, height: CGFloat(FLT_MAX)),
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font],
            context: nil).size.height
    }
    
}

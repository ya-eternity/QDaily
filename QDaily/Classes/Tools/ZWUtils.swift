//
//  ZWUtils.swift
//  QDaily
//
//  Created by bmxd-002 on 16/9/1.
//  Copyright © 2016年 Zoey. All rights reserved.
//

import UIKit

class ZWUtils {

    func heightForString(string: String, withFont font: UIFont, width: CGFloat) -> CGFloat {
        return string.boundingRectWithSize(
            CGSizeMake(width, CGFloat(FLT_MAX)),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font],
            context: nil).size.height
    }
    
}

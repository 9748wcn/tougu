//
//  HDToast.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/8.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit
import CLToast

class HDToast: NSObject {
    public static let share = HDToast()
    
    
   static func showTextToast(message:String?) {
    if let message = message {
        CLToastManager.share.textFont = UIFont.boldSystemFont(ofSize: 18)
        CLToastManager.share.textColor = UIColor.white
        CLToastManager.share.bgColor = UIColor(white: 0, alpha: 0.7)
        CLToastManager.share.cornerRadius = 8
        CLToast.cl_show(msg: message)
        }
    }
    
    
}

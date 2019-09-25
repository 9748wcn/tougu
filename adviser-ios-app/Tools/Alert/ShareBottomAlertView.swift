//
//  shareBottomAlertView.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/11.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class ShareBottomAlertView: UIView {
    
    weak var delegate: buttonClickDelegate!
    
    
    @IBAction func QQshareClick(_ sender: Any) {
        delegate.butonClickBy(sender as! UIButton)
    }
    @IBAction func wechatShareClick(_ sender: Any) {
        delegate.butonClickBy(sender as! UIButton)
    }
    
    @IBAction func closeShareClick(_ sender: Any) {
        delegate.butonClickBy(sender as! UIButton)
    }
    
    @IBAction func wechatFrendsClick(_ sender: Any) {
        delegate.butonClickBy(sender as! UIButton)
    }
}

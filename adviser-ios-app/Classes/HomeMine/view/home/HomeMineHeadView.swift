//
//  HomeMineHeadView.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/6.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class HomeMineHeadView: UIView {
    
   weak var delegate:buttonClickDelegate?
    
    @IBAction func seePersionInfo(_ sender: Any) {
        delegate?.butonClickBy(sender as! UIButton)
    }
    @IBAction func editCardClick(_ sender: Any) {
        delegate?.butonClickBy(sender as! UIButton)
    }
    @IBAction func shareCardClick(_ sender: Any) {
        delegate?.butonClickBy(sender as! UIButton)
    }
}

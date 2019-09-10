//
//  tabbarButton.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/9.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class tabbarButton: UIView {
    
    
    @IBOutlet weak var imageButton: UIButton!
    
    @IBOutlet weak var buttonNameLabel: UILabel!
    override func awakeFromNib() {
        imageButton.imageView?.contentMode = .scaleAspectFill
    }
    
}

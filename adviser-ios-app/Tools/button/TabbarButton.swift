//
//  tabbarButton.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/9.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class TabbarButton: UIView {
    
    typealias barButtonClickBlobk = () -> Void
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var buttonNameLabel: UILabel!
    var clickBlobk: barButtonClickBlobk?
    
    override func awakeFromNib() {
        imageButton.imageView?.contentMode = .scaleAspectFill
        let action = UITapGestureRecognizer(target: self, action: #selector(barButtonClick))
        self.addGestureRecognizer(action)
    }
    
    @objc func barButtonClick(){
        if self.clickBlobk != nil {
            self.clickBlobk!()
        }
    }
    
}

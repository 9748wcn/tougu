//
//  personInfoHeadView.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/6.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class PersonInfoHeadView: UIView {

    weak var delegate:buttonClickDelegate?
    
    @IBOutlet weak var headerImageBtn: UIButton!
    
    @IBAction func changeHeaderClick(_ sender: Any) {
        
        delegate?.butonClickBy(sender as! UIButton)
    }
    
    override func awakeFromNib() {
        
        headerImageBtn.layer.cornerRadius = 36
        headerImageBtn.clipsToBounds = true
        headerImageBtn.imageView?.contentMode = .scaleAspectFill
    }

}

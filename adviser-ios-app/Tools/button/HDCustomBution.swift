//
//  HDDateSelectBution.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/15.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit

class HDCustomBution: UIButton {
    
    var cornerRadius:CGFloat = 10
    var borderWidth:CGFloat = 0.5
    var borderColor:CGColor = UIColor.init(rgb: 0x4957E3).cgColor
    var normalBgImage:UIImage!
    var selectBgImage:UIImage!
    var normalBgColor:UIColor = UIColor.white
    var selectBgColor:UIColor = UIColor.init(rgb: 0x4957E3)
    
    override var isSelected: Bool{
        didSet {
            updateConfig(selected: isSelected)
        }
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.commonInit()
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    func commonInit() {
        self.layer.cornerRadius = cornerRadius;
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = borderColor;
    }
    
    func setupConfig(radius:CGFloat?=nil, borderW:CGFloat?=nil, borderC:CGColor?=nil, defaultImage:UIImage?=nil, selectImage:UIImage?=nil,defaultColor:UIColor?=nil, selectColor:UIColor?=nil) {
        if radius != nil {
            cornerRadius = radius!
            self.layer.cornerRadius = cornerRadius;
        }
        
        if borderW != nil {
            borderWidth = borderW!
            self.layer.borderWidth = borderWidth;
        }
        
        if borderC != nil {
            borderColor = borderC!
            self.layer.borderColor = borderColor;
        }
        
        if defaultImage != nil {
            normalBgImage = defaultImage!
            self.setBackgroundImage(normalBgImage, for: UIControl.State.normal)
        }
        
        if selectImage != nil {
            selectBgImage = selectImage!
            self.setBackgroundImage(selectBgImage, for: UIControl.State.selected)
        }
        
        if defaultColor != nil {
            normalBgColor = defaultColor!
            self.backgroundColor = normalBgColor
        }
        
        if selectColor != nil {
            selectBgColor = selectColor!
        }
        
    }
    
    func updateConfig(selected:Bool) {
        if selected {
            self.backgroundColor = self.selectBgColor
            
        }else {
            self.backgroundColor = self.normalBgColor
        }
        
    }
    
    deinit {
        
    }
}

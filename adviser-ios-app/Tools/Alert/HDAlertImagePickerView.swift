//
//  HDAlertImagePickerView.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/30.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit

class HDAlertImagePickerView: HDAlertBaseView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addRoundRect(radius: 8)
    }
    @IBAction func takePhoto(_ sender: Any) {
        hdSharedAlertManager.dismiss()
//        if self.delegate != nil {
            self.delegate?.alertClick?(index: 0)
//        }
    }
    @IBAction func selectImage(_ sender: Any) {
        hdSharedAlertManager.dismiss()
//        if self.delegate != nil {
            self.delegate?.alertClick?(index: 1)
//        }
    }
    @IBAction func cancel(_ sender: Any) {
        hdSharedAlertManager.dismiss()
    }
    
    deinit {
        
    }
    
}

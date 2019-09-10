//
//  VersionViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/10.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class VersionViewController: baseViewController {
    @IBOutlet weak var checkVersionBtn: UIButton!
    
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "版本信息"
        checkVersionBtn.layer.cornerRadius = 22.5
        checkVersionBtn.layer.borderColor = main_buttonColor.cgColor
        checkVersionBtn.layer.borderWidth = 1.0
        checkVersionBtn.setTitleColor(main_buttonColor, for: .normal)
        checkVersionBtn.backgroundColor = UIColor.white
    }

    @IBAction func checkVersionClick(_ sender: Any) {
        
    }
    

}

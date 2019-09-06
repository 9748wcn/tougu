//
//  resetPassWordSetViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/6.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class resetPassWordSetViewController: baseViewController {

    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var secondPassWordFeild: UITextField!
    @IBOutlet weak var firstNewPassWordFeild: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        finishBtn.backgroundColor = main_buttonColor
        finishBtn.setTitleColor(UIColor.white, for: .normal)
        finishBtn.layer.cornerRadius = 22.5
    }


    @IBAction func finishBtnClick(_ sender: Any) {
        
    }

}

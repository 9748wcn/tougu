//
//  resetPassWordVerifyViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/5.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class resetPassWordVerifyViewController: baseViewController {
    
    @IBOutlet weak var ICCardTextFeild: UITextField!
    @IBOutlet weak var phoneTextFeild: UITextField!
    @IBOutlet weak var codeTextFeild: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var getCodeBtn: HDCountDownButtion!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextBtn.backgroundColor = main_buttonColor
        nextBtn.setTitleColor(UIColor.white, for: .normal)
        nextBtn.layer.cornerRadius = 22.5
        
        getCodeBtn.layer.cornerRadius = 17.0
        getCodeBtn.layer.borderWidth = 1.0
        getCodeBtn.layer.borderColor = main_buttonColor.cgColor
        getCodeBtn.setTitleColor(main_buttonColor, for: .normal)
    }
    
    @IBAction func getCode(_ sender: Any) {
        getCodeBtn.isCounting = true
    }
    
    @IBAction func nextBtnClick(_ sender: Any) {
        
        let setPassWordVC: resetPassWordSetViewController = resetPassWordSetViewController()
        self.navigationController?.pushViewController(setPassWordVC, animated: true)
        
    }
    
}

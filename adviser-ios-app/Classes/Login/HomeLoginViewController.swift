//
//  HomeLoginViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/8/31.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class HomeLoginViewController: baseViewController {

    @IBOutlet weak var loginClick: UIButton!
    @IBOutlet weak var loginByPhoneClick: UIButton!
    @IBOutlet weak var loginByPassWordClick: UIButton!
    @IBOutlet var getPhoneCodeClick: HDCountDownButtion!
    
    @IBOutlet weak var icTextFeild: UITextField!
    
    @IBOutlet weak var phoneNumberTextFeild: UITextField!
    
    @IBOutlet weak var forgotPassWord: UIButton!
    
    @IBOutlet weak var codeTextFeild: UITextField!
    
    var scrollerToTypeView:UIView!
    var currentBtn: UIButton!
    weak var delegate: buttonClickDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentBtn = loginByPhoneClick
        forgotPassWord.isHidden = true
        loginClick.backgroundColor = main_buttonColor
        loginClick.setTitleColor(UIColor.white, for: .normal)
        loginClick.layer.cornerRadius = 22.5
        
        getPhoneCodeClick.layer.cornerRadius = 17.0
        getPhoneCodeClick.layer.borderWidth = 1.0
        getPhoneCodeClick.layer.borderColor = main_buttonColor.cgColor
        getPhoneCodeClick.setTitleColor(main_buttonColor, for: .normal)
        
        scrollerToTypeView = UIView.init()
        scrollerToTypeView.backgroundColor = main_buttonColor
        self.view.addSubview(scrollerToTypeView)
        scrollerToTypeView.snp.makeConstraints { (make) in
            make.top.equalTo(loginByPhoneClick.snp.bottom)
            make.centerX.equalTo(loginByPhoneClick.snp.centerX)
            make.width.equalTo(29)
            make.height.equalTo(3)
            
        }
        scrollerToTypeView.layer.cornerRadius = 1.5
        self.delegate = self
        
    }

    @IBAction func loginByPassWord(_ sender: Any) {
        if sender as? UIButton != currentBtn {
            self.delegate?.butonClickBy(sender as! UIButton)
        }
        
    }
    @IBAction func loginByPhone(_ sender: Any) {
        if sender as? UIButton != currentBtn {
            getPhoneCodeClick.isCounting = false
            self.delegate?.butonClickBy(sender as! UIButton)
        }
    }
    
    @IBAction func getPhoneCode(_ sender: Any) {
        getPhoneCodeClick.isCounting = true
    }
    
    @objc func eyeChangeStatus(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        codeTextFeild.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func forgotPassWordClick(_ sender: Any) {
        
        let setVC:resetPassWordVerifyViewController = resetPassWordVerifyViewController()
        self.navigationController?.pushViewController(setVC, animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

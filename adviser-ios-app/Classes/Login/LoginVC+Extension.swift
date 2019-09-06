//
//  LoginVC+Extension.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/5.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import Foundation

extension HomeLoginViewController: buttonClickDelegate{
    
    func butonClickBy(_ sender: UIButton) {
        if sender != currentBtn {
            currentBtn = sender
            self.getPhoneCodeClick.removeFromSuperview()
            self.getPhoneCodeClick = nil
            setupUIWithBtnType(sender: sender)
        }
    }
    
    func setupUIWithBtnType(sender: UIButton) {
        if sender == loginByPhoneClick{
            codeTextFeild.placeholder = "请输入短信验证码"
            codeTextFeild.text = nil
            codeTextFeild.isSecureTextEntry = false
            forgotPassWord.isHidden = true
            scrollerToTypeView.snp.remakeConstraints { (make) in
                make.centerX.equalTo(loginByPhoneClick.snp.centerX)
                make.width.equalTo(29)
                make.height.equalTo(3)
                make.top.equalTo(loginByPhoneClick.snp.bottom)
            }
            self.getPhoneCodeClick = HDCountDownButtion.init(type: .roundedRect)
            self.view.addSubview(getPhoneCodeClick)
            getPhoneCodeClick.snp.makeConstraints { (make) in
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.centerY.equalTo(codeTextFeild.snp.centerY)
                make.width.equalTo(115)
                make.height.equalTo(34)
            }
            getPhoneCodeClick.layer.cornerRadius = 17.0
            getPhoneCodeClick.layer.borderWidth = 1.0
            getPhoneCodeClick.layer.borderColor = main_buttonColor.cgColor
            getPhoneCodeClick.setTitleColor(main_buttonColor, for: .normal)
            getPhoneCodeClick.setTitle("获取验证码", for: .normal)
            getPhoneCodeClick.addTarget(self, action: #selector(getPhoneCode(_:)), for: .touchUpInside)
        }else {
            codeTextFeild.placeholder = "请输入登录密码"
            codeTextFeild.text = nil
            codeTextFeild.isSecureTextEntry = true
            forgotPassWord.isHidden = false
            scrollerToTypeView.snp.remakeConstraints { (make) in
                make.centerX.equalTo(loginByPassWordClick.snp.centerX)
                make.width.equalTo(29)
                make.height.equalTo(3)
                make.top.equalTo(loginByPassWordClick.snp.bottom)
            }
            self.getPhoneCodeClick = HDCountDownButtion.init(type: .custom)
            self.view.addSubview(getPhoneCodeClick)
            getPhoneCodeClick.snp.makeConstraints { (make) in
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.centerY.equalTo(codeTextFeild.snp.centerY)
                make.width.equalTo(20)
                make.height.equalTo(12)
        }
            getPhoneCodeClick.setImage(UIImage(named: "closeeye"), for: .normal)
            getPhoneCodeClick.setImage(UIImage(named: "openeye"), for: .selected)
            getPhoneCodeClick.isSelected = false
            getPhoneCodeClick.addTarget(self, action: #selector(eyeChangeStatus(_:)), for: .touchUpInside)
    }
        
  }
    
}

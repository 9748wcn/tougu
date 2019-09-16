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
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
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
        if vaildatePhone() {
            getPhoneCodeClick.isCounting = true
            getPhoneCodeNet(PhoneNo: self.phoneNumberTextFeild.text!)
        }
    }
    
    @objc func eyeChangeStatus(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        codeTextFeild.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func forgotPassWordClick(_ sender: Any) {
        
        let setVC:resetPassWordVerifyViewController = resetPassWordVerifyViewController()
        self.navigationController?.pushViewController(setVC, animated: true)
        
    }
    
    @IBAction func loginClick(_ sender: Any) {
        self.view.endEditing(true)
        guard vaildateICCode() else {
            return
        }
        guard vaildatePhone() else {
            return
        }
        guard vaildatePhoneCode() else {
            return
        }
        var type: NSInteger = 0
        var verify: String?
        var passwo: String?
        
        if currentBtn == loginByPhoneClick {
            type = 1
            verify = self.codeTextFeild.text!
            passwo = nil
        }else{
            type = 2
            passwo = self.codeTextFeild.text!
            verify = nil
        }
        requestData(loginType: type, phoneNo: self.phoneNumberTextFeild.text!, employeeNo: self.icTextFeild.text!, verifyCode: verify, password: passwo)
    }
    
     func vaildatePhone() -> Bool {
        let phone = self.phoneNumberTextFeild.text!
        if phone.isEmpty {
            HDToast.showTextToast(message: "请输入手机号")
            return false
        }
        
        guard phone.isPhoneNo() else {
            HDToast.showTextToast(message: "手机号格式不正确")
            return false
        }
        
        return true
    }
    
    func vaildateICCode() -> Bool {
        let ICCode = self.icTextFeild.text!
        if ICCode.isEmpty {
            HDToast.showTextToast(message: "请输入IC工号")
            return false
        }
        return true
    }
    
    func vaildatePhoneCode() -> Bool {
        let phoneCodeOrPassWord = self.codeTextFeild.text!
        if phoneCodeOrPassWord.isEmpty {
            if currentBtn == loginByPhoneClick {
                HDToast.showTextToast(message: "请输入验证码")
                return false
            }else {
                HDToast.showTextToast(message: "请输入登录密码")
                return false
            }
            
        }
        return true
        
    }
    
    func requestData(loginType: NSInteger,phoneNo: String,employeeNo: String,verifyCode: String?=nil,password:String?=nil) {
        let api = ASLoginProto()
        api.apiType = .normal
        api.loginType = loginType
        api.phoneNo = phoneNo
        api.employeeNo = employeeNo
        if verifyCode != nil {
            api.verifyCode = verifyCode!
        }
        if password != nil {
            api.password = password!
        }
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.start()
        
    }
    
    func getPhoneCodeNet(PhoneNo: String) {
        let api = ASGetPhoneCodeProto()
        api.apiType = .normal
        api.phoneNo = PhoneNo
        api.method = .get
        let request = HDHTTPRequest()
        request.api = api
        request.tag = "1000"
        request.delegate = self
        request.start()
    }
}
// MARK: --------------HDAsyncDelegate-------------
extension HomeLoginViewController: HDAsyncDelegate {
    func asyncerDidStart(request: HDHTTPRequest) {
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
        HDHudManager.shared.hide()
        guard request.tag == "1000" else {
            let loginModel = result as? ASLoginModel
            if loginModel?.code == 0{
                HDToast.showTextToast(message: (loginModel?.message)!)
                return
            }
            if loginModel?.code == 1002 {
                HDToast.showTextToast(message: "账号不存在，请重新输入")
                return
            }
            HDUserDefaults.hd_add(object: self.phoneNumberTextFeild.text!, forKey: USERPHONEKEY)
            HDUserDefaults.hd_add(object: (loginModel?.data?.employeeNumber!)!, forKey: USERICNO)
            //进入首页
            appDelegate.gotoMainVC()
            return
        }
        
    }
    
    func asyncerdidFailWithError(request: HDHTTPRequest, error: NSError) {
        
    }
    
    
}

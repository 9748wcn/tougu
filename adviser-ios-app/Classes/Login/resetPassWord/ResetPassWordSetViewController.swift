//
//  resetPassWordSetViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/6.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class ResetPassWordSetViewController: BaseViewController {

    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var secondPassWordFeild: UITextField!
    @IBOutlet weak var firstNewPassWordFeild: UITextField!
    public var phoneNumber: String!
    public var employeeNumber: String!
    
    var isfromLoginVC: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishBtn.isEnabled = false
        finishBtn.setTitleColor(UIColor.white, for: .normal)
        finishBtn.layer.cornerRadius = 22.5
        firstNewPassWordFeild.delegate = self
        firstNewPassWordFeild.isSecureTextEntry = true
        secondPassWordFeild.delegate = self
        secondPassWordFeild.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.isHidden = false
    }

    //这里重置密码之后跳转到登录页
    @IBAction func finishBtnClick(_ sender: Any) {
        if firstNewPassWordFeild.text! == secondPassWordFeild.text! {
            if firstNewPassWordFeild.text!.count < 8 {
                HDToast.showTextToast(message: "请输入8位及以上密码")
                return
            }
            requestSetPassWord(phoneNo: phoneNumber, password: firstNewPassWordFeild.text!, employeeNumber: employeeNumber)
        }else{
            HDToast.showTextToast(message: "两次输入的密码不一致")
            return
        }
        
    }
    
    func gotoLoginVC() {
        if isfromLoginVC {
            appDelegate.gotoLogin()
        }else {
            //跳转到设置界面
            let vcArray = self.navigationController?.viewControllers
            for (index,value) in vcArray!.enumerated() {
                if (value.isKind(of: SettingViewController.self)) {
                    self.navigationController?.popToViewController(value, animated: true)
                    return
                }
                if index == vcArray!.count - 1 {
                }
            }
        }
    }
    
    func requestSetPassWord(phoneNo: String, password: String, employeeNumber: String) {
        let api = ASResetPassWordProto()
        api.apiType = .normal
        api.phoneNo = phoneNo
        api.password = password
        api.employeeNumber = employeeNumber
        api.method = .post
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.tag = "100000"
        request.start()
    }

}

extension ResetPassWordSetViewController: HDAsyncDelegate {
    func asyncerDidStart(request: HDHTTPRequest) {
        if request.tag == "100000" {
            HDHudManager.shared.show()
//            finishBtn.isEnabled = false
        }
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
        if request.tag == "100000" {
            HDHudManager.shared.hide()
//            finishBtn.isEnabled = true
        }
        let resultModel = result as? HDBaseModel
        if resultModel?.code == 1 {
            //重置密码成功，跳转到登录页重新登录
            HDToast.showTextToast(message: (resultModel?.message)!)
            gotoLoginVC()
        }else {
            HDToast.showTextToast(message: (resultModel?.message)!)
        }
    }
    
    func asyncerdidFailWithError(request: HDHTTPRequest, error: NSError) {
        if request.tag == "100000" {
            HDHudManager.shared.hide()
//            finishBtn.isEnabled = true
        }
    }
    
    
}

extension ResetPassWordSetViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if textField == secondPassWordFeild {
            if firstNewPassWordFeild.text!.count > 0 && newText.count > 0 {
                finishBtn.isEnabled = true
            }else {
                finishBtn.isEnabled = false
            }
        }else if textField == firstNewPassWordFeild {
            if secondPassWordFeild.text!.count > 0 && newText.count > 0 {
                finishBtn.isEnabled = true
            }else {
                finishBtn.isEnabled = false
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.count < 8 {
            HDToast.showTextToast(message: "请输入8位及以上密码")
        }
    }
}

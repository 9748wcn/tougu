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
        if vaildatePhone() {
            getPhoneCodeNet(PhoneNo: phoneTextFeild.text!)
        }
        
    }
    
    @IBAction func nextBtnClick(_ sender: Any) {
        verifyInfoNet(employeeNomber: ICCardTextFeild.text!, phoneNo: phoneTextFeild.text!, verifyCode: codeTextFeild.text!)
    }
    
    func vaildatePhone() -> Bool {
        let phone = self.phoneTextFeild.text!
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
    
    func getPhoneCodeNet(PhoneNo: String) {
        let api = ASGetPhoneCodeProto()
        api.apiType = .normal
        api.phoneNo = PhoneNo
        api.method = .get
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.start()
    }
    
    func verifyInfoNet(employeeNomber: String, phoneNo: String, verifyCode: String) {
        let api = ASResetPassWordVerifyProto()
        api.apiType = .normal
        api.employeeNomber = employeeNomber
        api.phoneNo = phoneNo
        api.verifyCode = verifyCode
        api.method = .post
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.tag = "10000"
        request.start()
    }
    
    func gotoNextPage() {
        let setPassWordVC: resetPassWordSetViewController = resetPassWordSetViewController()
        setPassWordVC.phoneNumber = self.phoneTextFeild.text!
        self.navigationController?.pushViewController(setPassWordVC, animated: true)
    }
    
}

extension resetPassWordVerifyViewController: HDAsyncDelegate {
    func asyncerDidStart(request: HDHTTPRequest) {
        
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
        HDHudManager.shared.hide()
        if request.tag == "10000" {
            let loginModel = result as? ASLoginModel
            if loginModel?.code == 1 {
               gotoNextPage()
            }
        }else{
            let resultModel = result as? HDBaseModel
            if resultModel?.code == 1 {
                getCodeBtn.isCounting = true
                HDToast.showTextToast(message: "发送成功")
            }
        }
    }
    
    func asyncerdidFailWithError(request: HDHTTPRequest, error: NSError) {
        HDHudManager.shared.hide()
//        let resultModel =
        
    }
    
    
}

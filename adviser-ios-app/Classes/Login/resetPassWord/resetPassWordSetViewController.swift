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
    public var phoneNumber: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishBtn.isEnabled = false
        finishBtn.setTitleColor(UIColor.white, for: .normal)
        finishBtn.layer.cornerRadius = 22.5
        firstNewPassWordFeild.delegate = self
        secondPassWordFeild.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    //这里重置密码之后跳转到登录页
    @IBAction func finishBtnClick(_ sender: Any) {
        if firstNewPassWordFeild.text! == secondPassWordFeild.text! {
            requestSetPassWord(phoneNo: phoneNumber, password: firstNewPassWordFeild.text!)
        }else{
            HDToast.showTextToast(message: "两次输入的密码不一致")
            return
        }
        
    }
    
    func gotoLoginVC() {
        let vcArray = self.navigationController?.viewControllers
        for (index,value) in vcArray!.enumerated() {
            if (value.isKind(of: HomeLoginViewController.self)) {
                self.navigationController?.popToViewController(value, animated: true)
            }
            if index == vcArray!.count - 1 {
                let vc: HomeLoginViewController = HomeLoginViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    func requestSetPassWord(phoneNo: String, password: String) {
        let api = ASResetPassWordProto()
        api.apiType = .normal
        api.phoneNo = phoneNo
        api.password = password
        api.method = .post
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.tag = "100000"
        request.start()
    }

}

extension resetPassWordSetViewController: HDAsyncDelegate {
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

extension resetPassWordSetViewController: UITextFieldDelegate {
    
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
}

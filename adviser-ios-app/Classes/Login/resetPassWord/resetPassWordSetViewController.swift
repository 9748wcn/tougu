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

        finishBtn.backgroundColor = main_buttonColor
        finishBtn.setTitleColor(UIColor.white, for: .normal)
        finishBtn.layer.cornerRadius = 22.5
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
        for vc: UIViewController? in vcArray! {
            if (vc?.isKind(of: HomeLoginViewController.self))! {
                self.navigationController?.popToViewController(vc!, animated: true)
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
        request.start()
    }

}

extension resetPassWordSetViewController: HDAsyncDelegate {
    func asyncerDidStart(request: HDHTTPRequest) {
        
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
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
        
    }
    
    
}

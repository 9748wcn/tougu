//
//  LogoutSystemManager.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/19.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class LogoutSystemManager: NSObject, HDAsyncDelegate {
    
//    static let shared = LogoutSystemManager()
    override init() {
        super.init()
    }
    var vc:BaseViewController!
    
    func logoutSystem(vc: BaseViewController, phoneNo: String) {
        
        self.vc = vc
        let api = LogoutSystemProto()
        api.phoneNo = phoneNo
        api.method = .get
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.start()
        
    }
    
    func asyncerDidStart(request: HDHTTPRequest) {
        //        MBProgressHUD.sho
        HDHudManager.shared.show()
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
        HDHudManager.shared.hide()
        let model = result as? HDBaseModel
        if model?.code == 1 {
            //布局界面
            if let SettingVC = self.vc as? SettingViewController {
                SettingVC.logoutSeccuss()
            }
        }
        
    }
    
    func asyncerdidFailWithError(request: HDHTTPRequest, error: NSError) {
        HDHudManager.shared.hide()
    }

}

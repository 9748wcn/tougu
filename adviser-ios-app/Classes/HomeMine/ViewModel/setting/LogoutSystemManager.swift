//
//  LogoutSystemManager.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/19.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class LogoutSystemManager: NSObject, HDAsyncDelegate {
    
    static let shared = LogoutSystemManager()
    var vc:baseViewController!
    
    func logoutSystem(vc: baseViewController, phoneNo: String) {
        
        self.vc = vc
        let api = LogoutSystemProto()
        api.phoneNo = phoneNo
        api.method = .post
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.start()
        
    }
    
    func asyncerDidStart(request: HDHTTPRequest) {
        //        MBProgressHUD.sho
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
        let model = result as? HDBaseModel
        if model?.code == 1 {
            //布局界面
            if let SettingVC = self.vc as? SettingViewController {
                SettingVC.logoutSeccuss()
            }
        }
        
    }
    
    func asyncerdidFailWithError(request: HDHTTPRequest, error: NSError) {
        
    }

}

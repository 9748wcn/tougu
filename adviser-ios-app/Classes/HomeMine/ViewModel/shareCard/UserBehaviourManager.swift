//
//  UserBehaviourManager.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/19.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class UserBehaviourManager: NSObject,HDAsyncDelegate {
    
//    static let shared = UserBehaviourManager()
    override init() {
        super.init()
    }
    var vc:BaseViewController!
    
    func getBehaviourInfo(vc: BaseViewController,phoneNo: String) {
        self.vc = vc
        let api = UserBehaviourCountProto()
        api.phoneNo = phoneNo
        api.method = .get
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.start()
    }
    
    func asyncerDidStart(request: HDHTTPRequest) {
    
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
        HDHudManager.shared.hide()
        let model = result as? UserBehaviourModel
        if model?.code == 1 && ((model?.data) != nil) {
            //布局界面
            if let shareMainVC = self.vc as? HomeMineShareCardViewController {
                shareMainVC.updateUserBehaviourUI(userBehaviour: model!)
                
            }
        }
        
    }
    
    func asyncerdidFailWithError(request: HDHTTPRequest, error: NSError) {
    }

}

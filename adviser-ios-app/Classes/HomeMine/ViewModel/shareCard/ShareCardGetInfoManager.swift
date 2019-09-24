//
//  ShareCardGetInfoManager.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/16.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class ShareCardGetInfoManager: NSObject,HDAsyncDelegate {
    
//    static let shared = ShareCardGetInfoManager()
    override init() {
        super.init()
    }
    var vc:baseViewController!
    
    func getemployeeInfo(vc: baseViewController,phoneNo: String) {
        self.vc = vc
        let api = shareCardGetInfoProto()
        api.phoneNo = phoneNo
        api.method = .get
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.start()
    }
    
    func asyncerDidStart(request: HDHTTPRequest) {
//        HDHudManager.shared.show()
//        if let shareMainVC = self.vc as? HomeMineShareCardViewController {
//            shareMainVC.startGetData()
//        }
//
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
        HDHudManager.shared.hide()
        let model = result as? shareCardModel
        if model?.code == 1 && ((model?.data) != nil) && ((model?.data?.data) != nil) {
            //布局界面
            if let shareMainVC = self.vc as? HomeMineShareCardViewController {
                shareMainVC.updateHeaderView(shareModel: model!)
                shareMainVC.getDataFinish()
            }
        }
        
    }
    
    func asyncerdidFailWithError(request: HDHTTPRequest, error: NSError) {
        
        if let shareMainVC = self.vc as? HomeMineShareCardViewController {
            shareMainVC.getDataFinish()
        }
    }
    

}

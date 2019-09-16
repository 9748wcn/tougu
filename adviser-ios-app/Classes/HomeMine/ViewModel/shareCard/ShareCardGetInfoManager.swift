//
//  ShareCardGetInfoManager.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/16.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class ShareCardGetInfoManager: NSObject,HDAsyncDelegate {
    
    static let shared = ShareCardGetInfoManager()
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
        
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
        let model = result as? shareCardInfoModel
        if model?.code == 1 {
            //布局界面
            if let shareMainVC = self.vc as? HomeMineShareCardViewController {
                shareMainVC.updateHeaderView(shareModel: model!)
            }
        }
        
    }
    
    func asyncerdidFailWithError(request: HDHTTPRequest, error: NSError) {
        
    }
    

}

//
//  PersonInfoGetValueManager.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class PersonInfoGetValueManager: NSObject, HDAsyncDelegate {
    
//    static let shared = PersonInfoGetValueManager()
    override init() {
        super.init()
    }
    var vc:BaseViewController!
    
    func getPersonInfo(vc: BaseViewController, phoneNo: String) {
        
        self.vc = vc
        let api = PersonInfoProto()
        api.phoneNo = phoneNo
        api.method = .get
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.start()
        
    }
    
    func asyncerDidStart(request: HDHTTPRequest) {
//        HDHudManager.shared.show()
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
//        HDHudManager.shared.hide()
        let model = result as? PersonInfoModel
        if model?.code == 1 && ((model?.data) != nil) {
            //布局界面
            if let HomeMineVC = self.vc as? HomeMineViewController {
                HomeMineVC.updateHeaderInfo(model: model!)
            }
        }
    }
    
    func asyncerdidFailWithError(request: HDHTTPRequest, error: NSError) {
//        HDHudManager.shared.hide()
    }

}

//
//  VersionValueManager.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class VersionValueManager: NSObject, HDAsyncDelegate {
    
    static let shared = VersionValueManager()
    var vc:baseViewController!
    
    func getVersionValue(vc: baseViewController) {
        self.vc = vc
        let api = VersionValueProto()
        api.method = .get
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.start()
    }
    
    func asyncerDidStart(request: HDHTTPRequest) {
        HDHudManager.shared.show()
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
        HDHudManager.shared.hide()
        let model = result as? VersionModel
        if model?.code == 1 && ((model?.data) != nil) {
            //布局界面
            if let versionVC = self.vc as? VersionViewController {
                versionVC.updateVersion(versionModel: model!)
            }
        }
    }
    
    func asyncerdidFailWithError(request: HDHTTPRequest, error: NSError) {
        
    }

}

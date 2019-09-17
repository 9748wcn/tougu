//
//  PersonInfoGetValueManager.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class PersonInfoGetValueManager: NSObject, HDAsyncDelegate {
    
    static let shared = PersonInfoGetValueManager()
    var vc:baseViewController!
    
    func getPersonInfo(vc: baseViewController, phoneNo: String) {
        
        self.vc = vc
        let api = personInfoProto()
        api.phoneNo = phoneNo
        api.method = .get
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.start()
        
    }
    
    func asyncerDidStart(request: HDHTTPRequest) {
//        MBProgressHUD.sho
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
        let model = result as? personInfoModel
        if model?.code == 1 && ((model?.data) != nil) {
            //布局界面
            if let personVC = self.vc as? personInfoViewController {
                personVC.setupWithData(firstValueArray: [model?.data?.employeeName,model?.data?.phoneNo,model?.data?.employeeNumber,model?.data?.jobName], secondValueArray: [model?.data?.parentGroupName,model?.data?.groupName,model?.data?.groupType])
            }
        }
        
    }
    
    func asyncerdidFailWithError(request: HDHTTPRequest, error: NSError) {
        
    }

}

//
//  BusinessCardEditManager.swift
//  adviser-ios-app
//
//  Created by HDCF003 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

enum businessCardActionType {
    case request
    case update
}

class BusinessCardEditManager: NSObject,HDAsyncDelegate {
    
//    static let shared = businessCardEditManager()
    
    private var vc:BusinessCardEditViewController!
    private var netType:businessCardActionType!
    override init() {
        super.init()
    }
    
    func getCardInfo(vc: BusinessCardEditViewController,
                     employeeNumber: String) {
        self.vc = vc
        self.netType = .request
        let api = BusinessCardEditProto(employeeNumber: employeeNumber)
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.start()
    }
    func updateCardInfo(vc: BusinessCardEditViewController,
                        paramter: [String:Any]) {
        self.vc = vc
        self.netType = .update
        let api = businessUpdateCardProto(paramert: paramter)
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.start()
    }
    
    
    func asyncerDidStart(request: HDHTTPRequest) {
        
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
        guard let netType = self.netType else { return }
        switch netType {
            case .request:
            if let model = result as? businessCardNetModel, model.code == 1 {
                self.vc.refrenUI(with: model.data ?? BusinessCardModel())
            }
            case .update:()
            if let model = result as? HDBaseModel,model.code == 1  {
                HDToast.showTextToast(message: "提交成功，请耐性等候审核!")
                self.vc.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func asyncerdidFailWithError(request: HDHTTPRequest, error: NSError) {
        
    }
}

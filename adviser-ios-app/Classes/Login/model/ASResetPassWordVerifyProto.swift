//
//  ASResetPassWordVerifyProto.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/16.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class ASResetPassWordVerifyProto: HDBaseApi {
    
    override init() {
        super.init()
        urlString = "/login/infoVerify"
    }
    var employeeNomber: String = ""
    var phoneNo: String = ""
    var verifyCode: String = ""
    
    override func responseObjectFromJson<T>(jsonStr: String) -> T where T : HDBaseModel {
        return ASLoginModel.deserialize(from: jsonStr) as! T
    }
    
    override func getParameters() -> [String: Any]? {
        
        return ["employeeNomber":employeeNomber, "phoneNo":phoneNo, "verifyCode":verifyCode]
    }

}

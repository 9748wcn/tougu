//
//  ASResetPassWordProto.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/16.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class ASResetPassWordProto: HDBaseApi {
    override init() {
        super.init()
        urlString = "/login/resetPassword"
    }
    
    var password: String = ""
    var phoneNo: String = ""
    var employeeNumber: String = ""

    override func responseObjectFromJson<T>(jsonStr: String) -> T where T : HDBaseModel {
        return HDBaseModel.deserialize(from: jsonStr) as! T
    }
    
   override func getParameters() -> [String: Any]? {
    return ["phoneNo":phoneNo, "password":password,"employeeNumber":employeeNumber]
    }
}

//
//  ASLoginProto.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/10.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class ASLoginProto: HDBaseApi {
    
    override init() {
        super.init()
        urlString = "/login/login"
    }
    //验证码登录参数
    var loginType: NSInteger!
    var employeeNo: String = ""
    var verifyCode: String = ""
    var phoneNo: String = ""
    
    //密码登录参数
    var password: String = ""
    
    override func responseObjectFromJson<T>(jsonStr: String) -> T where T : HDBaseModel {
       return ASLoginModel.deserialize(from: jsonStr) as! T
    }
    
   override func getParameters() -> [String: Any]? {
    if loginType == 1 {
        return ["phoneNo":phoneNo, "employeeNo":employeeNo, "verifyCode":verifyCode, "loginType":loginType!]
    }else {
        return ["phoneNo":phoneNo, "employeeNo":employeeNo, "password":password, "loginType":loginType!]
    }
    
  }
    
    
    

}

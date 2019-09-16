//
//  ASGetPhoneCodeProto.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/16.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class ASGetPhoneCodeProto: HDBaseApi {
    
    override init() {
        super.init()
        urlString = "/sms/getCode"
    }
    
    var phoneNo: String = ""
    
   override func getParameters() -> [String: Any]? {
    
        return ["phoneNo":phoneNo]
    }
    
    override func responseObjectFromJson<T>(jsonStr: String) -> T where T : HDBaseModel {
        return HDBaseModel.deserialize(from: jsonStr) as! T
    }

}

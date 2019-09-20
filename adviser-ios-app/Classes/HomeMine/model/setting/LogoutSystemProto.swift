//
//  LogoutSystemProto.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/19.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class LogoutSystemProto: HDBaseApi {
    
    override init() {
        super.init()
        urlString = "/login/logout"
    }
    
    var phoneNo: String = ""
    
    override func responseObjectFromJson<T>(jsonStr: String) -> T where T : HDBaseModel {
        return HDBaseModel.deserialize(from: jsonStr) as! T
    }
    
    override func getParameters() -> [String: Any]? {
//        return ["phoneNo":phoneNo]
        return [:]
    }

}

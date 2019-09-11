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
        urlString = ""
    }
    
    var icCode: String = ""
    var password: String = ""
    var phoneValue: String = ""
    var phoneCode: String = ""
    
    override func responseObjectFromJson<T>(jsonStr: String) -> T where T : HDBaseModel {
       return ASLoginModel.deserialize(from: jsonStr) as! T
    }
    
   override func getParameters() -> [String: Any]? {
        return ["icCode":icCode,"password":password,"phoneValue":phoneValue,"phoneCode":phoneCode]
    }
    
    
    

}

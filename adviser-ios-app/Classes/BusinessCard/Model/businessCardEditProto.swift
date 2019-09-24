//
//  BusinessCardEditProto.swift
//  adviser-ios-app
//
//  Created by HDCF003 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class businessCardEditProto: HDBaseApi {
    var employeeNumber: String = ""
    convenience init(employeeNumber:String) {
        self.init()
        self.employeeNumber = employeeNumber
        self.method = .get
        self.urlString = "/investadviser/showEditInvestAdviserInfo"
    }
    override func responseObjectFromJson<T>(jsonStr: String) -> T where T : HDBaseModel {
        return businessCardNetModel.deserialize(from: jsonStr) as! T
    }
    override func getParameters() -> [String: Any]? {
        return ["employeeNumber":employeeNumber]
    }
}

class businessUpdateCardProto: HDBaseApi {
    var paramert:[String:Any] = [:]
    convenience init(paramert:[String:Any]) {
        self.init()
        self.paramert = paramert
        urlString = "/investadviser/updateInvestAdviser"
        method = .post
    }
    override func responseObjectFromJson<T>(jsonStr: String) -> T where T : HDBaseModel {
        return businessCardModel.deserialize(from: jsonStr) as! T
    }
    override func getParameters() -> [String: Any]? {
        return paramert
    }
}

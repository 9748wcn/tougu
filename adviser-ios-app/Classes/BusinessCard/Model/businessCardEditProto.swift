//
//  BusinessCardEditProto.swift
//  adviser-ios-app
//
//  Created by HDCF003 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class businessCardEditProto: HDBaseApi {
    var phoneNo: String = ""
    convenience init(phoneNo:String) {
        self.init()
        self.phoneNo = phoneNo
        self.method = .get
        self.urlString = "/investadviser/queryInvestAdviser"
    }
    override func responseObjectFromJson<T>(jsonStr: String) -> T where T : HDBaseModel {
        return businessCardModel.deserialize(from: jsonStr) as! T
    }
    override func getParameters() -> [String: Any]? {
        return ["phoneNo":phoneNo]
    }
}

class businessUpdateCardProto: HDBaseApi {
    var paramert:[String:Any] = [:]
    convenience init(paramert:[String:Any]) {
        self.init()
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

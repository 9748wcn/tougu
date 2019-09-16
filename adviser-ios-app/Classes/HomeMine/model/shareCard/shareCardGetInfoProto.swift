//
//  shareCardGetInfoProto.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/16.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class shareCardGetInfoProto: HDBaseApi {
    override init() {
        super.init()
        urlString = "/investadviser/queryInvestAdviser"
    }
    var phoneNo: String = ""
    
    override func responseObjectFromJson<T>(jsonStr: String) -> T where T : HDBaseModel {
        return shareCardInfoModel.deserialize(from: jsonStr) as! T
    }
    
    override func getParameters() -> [String: Any]? {
        return ["phoneNo":phoneNo]
    }
    

}

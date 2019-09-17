//
//  VersionValueProto.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class VersionValueProto: HDBaseApi {
    
    override init() {
        super.init()
        urlString = "/investadviser/queryVersionNo"
    }
    
    override func responseObjectFromJson<T>(jsonStr: String) -> T where T : HDBaseModel {
        return VersionModel.deserialize(from: jsonStr) as! T
    }
    
    override func getParameters() -> [String: Any]? {
        return [:]
    }

}

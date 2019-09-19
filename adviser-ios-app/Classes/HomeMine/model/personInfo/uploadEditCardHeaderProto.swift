//
//  uploadEditCardHeaderProto.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/19.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class uploadEditCardHeaderProto: HDBaseApi {
    
    override init() {
        super.init()
        urlString = "/upload/uploadFile"
    }
    var phoneNo: String = ""
    var imageType: Int?
    var portraitImage: String = "" //base64 数据
    
    override func responseObjectFromJson<T>(jsonStr: String) -> T where T : HDBaseModel {
        return uploadCardHeaderModel.deserialize(from: jsonStr) as! T
    }
    
    override func getParameters() -> [String: Any]? {
        return ["portraitImage":portraitImage,"phoneNo":phoneNo,"imageType":imageType!]
    }

}

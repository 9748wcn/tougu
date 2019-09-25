//
//  uploadImageProto.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/18.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class UploadImageProto: HDBaseApi {
    
    override init() {
        super.init()
        urlString = "/upload/updatePortrait"
    }
    var phoneNo: String = ""
    var imageType: Int?
    var portraitImage: String = "" //base64 数据
    
    override func responseObjectFromJson<T>(jsonStr: String) -> T where T : HDBaseModel {
        return HDBaseModel.deserialize(from: jsonStr) as! T
    }
    
    override func getParameters() -> [String: Any]? {
        return ["portraitImage":portraitImage,"phoneNo":phoneNo,"imageType":imageType!]
    }

}

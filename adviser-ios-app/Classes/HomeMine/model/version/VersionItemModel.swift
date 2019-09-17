//
//  VersionItemModel.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import HandyJSON

class VersionItemModel: HandyJSON {
    var version_no: String?
    var androidAddress: String?
    var iosAddress: String?
    var profile: String?
    
    required init() {}

}

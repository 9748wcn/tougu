//
//  HDBaseModel.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/2.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit
import HandyJSON

class HDBaseModel: HandyJSON {
    var code:Int = 0
    var errMessage:String?
    required init() {}
}

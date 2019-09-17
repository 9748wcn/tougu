//
//  businessCardModel.swift
//  adviser-ios-app
//
//  Created by HDCF003 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//
import HandyJSON
import UIKit

class businessCardModel: HDBaseModel {
    var data:businessCardItemModel?
}

class businessCardItemModel: HandyJSON {
    required init() {}
    var wechatAccount:String = ""
    var employeeName:String = ""
    var profile:String = ""
    var avatar:String = ""
    var employeeNo:String = ""
    var phoneNo:String = ""
    var email:String = ""
    var jobNames:String = ""
    
}

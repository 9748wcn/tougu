//
//  businessCardModel.swift
//  adviser-ios-app
//
//  Created by HDCF003 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//
import HandyJSON
import UIKit

class businessCardNetModel: HDBaseModel {
    var data:BusinessCardModel?
}

class BusinessCardModel: HDBaseModel {
    var data:businessCarddataModel?
    var createTime: String = ""
    var refuseReason: String = ""
    var examineStatus: Int = 0
}

class businessCarddataModel: HDBaseModel {
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
    var updateTime:String = ""
    var employeeNumber:String = ""
    var memberNo:String = ""
    var createBy:String = ""
    var createTime:String = ""
    var updateBy:String = ""
    var landline:String = ""
    var status: Int = 0
    
}

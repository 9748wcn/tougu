//
//  UserBehaviourModel.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/19.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import HandyJSON

class UserBehaviourModel: HDBaseModel {
    
    var data: Array<UserBehaviourItemModel>?
}

class UserBehaviourItemModel: HandyJSON {
    
    var userName: String?
    var avatar: String?
    var investAdviserId: Int?
    var authorizeTime: String?
    var viewBusinessCard: Int?
    var callUp: Int?
    var copyWechatAccount: Int?
    var copyEmail: Int?
    var enterRegister: Int?
    var bindSuccess: Int?
    var createTime: String?
    var updateTime: String?
    
    required init() {}
}

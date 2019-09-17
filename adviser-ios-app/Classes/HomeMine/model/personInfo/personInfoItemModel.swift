//
//  personInfoItemModel.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import HandyJSON

class personInfoItemModel: HandyJSON {
    var phoneNo: String?
    var employeeName: String?
    var groupName: String?
    var groupType: String?
    var avatar: String?
    var parentGroupName: String?
    var employeeNumber: String?
    var jobName: String?
    
    required init() {}

}

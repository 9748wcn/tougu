//
//  HDDeviceInfo.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/10.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit

class HDDeviceInfo: NSObject {
    class func uuid() -> String {
        var uuid:String = NSUUID().uuidString.lowercased()
        if uuid.isEmpty {
            let uuidRef = CFUUIDCreate(nil)
            let uuidStringRef = CFUUIDCreateString(nil,uuidRef)
            uuid = uuidStringRef! as String
        }
        return uuid
    }
    
  class func appVersion() -> String {
        let infoDictionary = Bundle.main.infoDictionary
    let majorVersion = infoDictionary?["CFBundleShortVersionString"]//主程序版本号
    return "\(majorVersion ?? "1.0")"
    }
}

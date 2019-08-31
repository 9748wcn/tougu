//
//  HDClientIDService.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/10.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit
import Foundation

class HDClientIDService: NSObject {
   static var s_uuid:String?
   static func clientId() -> String {
        if s_uuid != nil {
           return s_uuid!
        }
        s_uuid = HDKeyChainHelper.load(service: "kClientId") as? String
        if s_uuid != nil {
            return s_uuid!
        }else {
           s_uuid = String.init(format: "%@%@", HDDeviceInfo.uuid(),HDDeviceInfo.uuid())
            HDKeyChainHelper.save(service: "kClientId", data: s_uuid as Any)
        }
        return s_uuid!;
    }
}

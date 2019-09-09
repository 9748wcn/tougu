//
//  UmengShareManager.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/9.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class UmengShareManager: NSObject {
    
    let wechatAppId = "wxdec919c0059ca1c2"
    let wechatAppSecret = "8fc0f54189b2bcdbe87ffb1884bec1ba"
    let qqShareAppId = "101777145"
    let qqShareAppKey = "1cccbc8a1ca511f0f899fa9d854ed021"
    let umengKey = "5d7628a54ca3576cdb0001cd"
    
    
    static let sharedInstance = UmengShareManager()
    private override init() {
        
    }
    
    func configUSharePlatforms() {
        UMConfigure.initWithAppkey(umengKey, channel: "App Store")
        UMSocialManager.default()?.setPlaform(UMSocialPlatformType.wechatSession, appKey: wechatAppId, appSecret: wechatAppSecret, redirectURL: "http://mobile.umeng.com/social")
        UMSocialManager.default()?.setPlaform(UMSocialPlatformType.wechatTimeLine, appKey: wechatAppId, appSecret: wechatAppSecret, redirectURL: "http://mobile.umeng.com/social")
        UMSocialManager.default()?.setPlaform(UMSocialPlatformType.wechatTimeLine, appKey: qqShareAppId, appSecret: nil, redirectURL: "http://mobile.umeng.com/social")
    }
    
    
    
    
    

}

//
//  AppColor.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/5.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import Foundation

//按钮主色
public let main_buttonColor = UIColor(rgb: 0x497BEC)

//不可选按钮色
public let noClick_buttonColor = UIColor(rgb: 0xA4BDF5)

//背景色
public let background_Color = UIColor(rgb: 0xF8F8F8)

//文字常规色
public let text_Color = UIColor(rgb: 0x27314A)

//不可编辑文字颜色
public let Notext_Color = UIColor(rgb: 0x8F94A7)

//首页背景色
public let HomeBackground_Color = UIColor(rgb: 0xF6F7F8)

//浅分割色
public let lightSeparate_Color = UIColor(rgb: 0xF1F5FE)

public let is_iphoneX = (screenWidth >= 375.0 && screenHeight >= 812.0)

public let bottomSafeHeight = CGFloat(is_iphoneX ? 34.0 : 0)

public let navHeight = CGFloat(is_iphoneX ? 88.0 : 64.0)


//12号字体
public let textFont12 = UIFont.systemFont(ofSize: 12.0)
//10号字体
public let textFont10 = UIFont.systemFont(ofSize: 10.0)
//14号字体
public let textFont14 = UIFont.systemFont(ofSize: 14.0)

extension String {
    
       func turnToNormalDate() -> String {
        let dateFormat: DateFormatter = DateFormatter.init()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let localTimeZone = NSTimeZone.local
        dateFormat.timeZone = localTimeZone
        let dateFormatted = dateFormat.date(from: self)
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if dateFormatted != nil {
            let value = dateFormat.string(from: dateFormatted!)
            return value
        }else {
            return self
        }
    }
}


//
//  HDStringExtend.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/8.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import Foundation
extension String {
    
    func isPurnInt() -> Bool {
        let scan: Scanner = Scanner(string: self)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
        
    }
    
    func isPhoneNo () -> Bool {
        let pattern = "^1[0-9]{10}$"
        if NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
        {
        return true
        }
        return false
    }
    
    func phoneNOSecurity () -> String {
        var phoneSecurity = self
        let startIndex = phoneSecurity.index(phoneSecurity.startIndex, offsetBy: 3)
        let endIndex  = phoneSecurity.index(phoneSecurity.startIndex, offsetBy: 6)
        phoneSecurity.replaceSubrange(startIndex...endIndex, with: "****")
        return phoneSecurity
    }
    
    func isPassword() -> Bool {
        let pattern = "^(?![\\d]+$)(?![a-zA-Z]+$)(?![^\\da-zA-Z]+$).{1,50}$"
        if NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
        {
            return true
        }
        return false
        
    }
    
    func isOnlyNumber() -> Bool {
        let pattern = "^[0-9]*$"
        if NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
        {
            return true
        }
        return false
    }
    
    func isOnlyLetter() -> Bool {
        let pattern = "^[A-Za-z]+$"
        if NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
        {
            return true
        }
        return false
    }
    
    
    // JSONString转换为字典
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        let jsonData:Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    func judgeJsonStringIsRight() -> Bool {
        let dict = getDictionaryFromJSONString(jsonString: self) as! Dictionary<String, Any>
        let dataDict = dict["data"]
        
        if let dict1 = dataDict as? Dictionary<String, Any>{
            if dict1.count <= 0 {
                return false
            }
        }
        if let array = dataDict as? Array<Any>{
            if array.count <= 0 {
                return false
            }
        }
        return true
    }
    
    
}
//MARK:-- 获取文本的宽高 --
extension String{
    /// 获取文本高度
    ///
    /// - Parameters:
    ///   - font: font
    ///   - fixedWidth: fixedWidth
    func obtainTextHeight(font : UIFont = UIFont.systemFont(ofSize: 18), fixedWidth : CGFloat) -> CGFloat {
        
        guard self.count > 0 && fixedWidth > 0 else {
            return 0
        }
        let size = CGSize(width:fixedWidth, height:CGFloat.greatestFiniteMagnitude)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context:nil)
        
        return rect.size.height
    }
    /// 获取文本宽度
    ///
    /// - Parameter font: font
    func obtainTextWidth(font : UIFont = UIFont.systemFont(ofSize: 17)) -> CGFloat {
        
        guard self.count > 0 else {
            return 0
        }
        let size = CGSize(width:CGFloat.greatestFiniteMagnitude, height:0)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context:nil)
        return rect.size.width
    }
    
}

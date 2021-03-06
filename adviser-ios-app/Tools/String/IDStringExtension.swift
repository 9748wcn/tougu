//
//  StringUtils.swift
//  Ideal-IOS
//
//  Created by darren on 2018/12/4.
//  Copyright © 2018年 陈亮陈亮. All rights reserved.
//

import UIKit
public extension String {
    /// 字符串截取函数
    func id_subString(to index: Int) -> String {
        if index >= self.count {
            return String(self[..<self.index(self.startIndex, offsetBy: self.count)])
        }
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    /// 字符串截取函数
    func id_subString(from index: Int) -> String {
        if index >= self.count {
            return String(self[self.index(self.startIndex, offsetBy: self.count)...])
        }
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
    
    func id_subString(from index: Int, offSet: Int) -> String {
        let begin = self.id_subString(from: index)
        let str = begin.id_subString(to: offSet)
        return str
    }
    
    /// range转换为NSRange
    func id_range(from range: Range<String.Index>) -> NSRange? {
        let utf16view = self.utf16
        if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
            return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
        }
        return nil
    }
    
}

//转换后台给的时间格式
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

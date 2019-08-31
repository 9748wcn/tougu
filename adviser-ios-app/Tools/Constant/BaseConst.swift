//
//  BaseConst.swift
//  mgr-combat-map-ios
//
//  Created by HDCF003 on 2019/7/29.
//  Copyright © 2019 evergrande_caifu_manager. All rights reserved.
//
import RxSwift
import RxCocoa
import Foundation

//rgb
func kRGB(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}
let appDelegate = UIApplication.shared.delegate as! AppDelegate


//转类型的函数（转换失败后，会发出Error）
func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}

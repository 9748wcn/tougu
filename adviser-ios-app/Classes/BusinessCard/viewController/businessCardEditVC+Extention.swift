//
//  businessCardEditVC+Extention.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/2.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import Foundation

extension businessCardEditViewController {
    private struct AssociatedKeys {
        static var nameTextFeild: UITextField!
        static var positionTextFeild: UITextField!
        static var phoneTextFeild: UITextField!
        static var wechatTextFeild: UITextField!
        static var emailTextFeild: UITextField!
        
    }
    var nameTextFeild: UITextField {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.nameTextFeild) as? UITextField ?? UITextField()
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.nameTextFeild, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    var positionTextFeild: UITextField {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.positionTextFeild) as? UITextField ?? UITextField()
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.positionTextFeild, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    var phoneTextFeild: UITextField {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.phoneTextFeild) as? UITextField ?? UITextField()
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.phoneTextFeild, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    var wechatTextFeild: UITextField {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.wechatTextFeild) as? UITextField ?? UITextField()
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.wechatTextFeild, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    var emailTextFeild: UITextField {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.emailTextFeild) as? UITextField ?? UITextField()
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.emailTextFeild, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
}

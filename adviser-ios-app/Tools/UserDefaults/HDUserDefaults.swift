//
//  HDUserDefaults.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/20.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit
//let HDUSERNAMELOGINED = "HDUSERNAMELOGINED"
//let HDTEAMSEARCHRECORD = "HDTEAMSEARCHRECORD"
let USERICNO = "USERICNO"
let USERPASSWORDKEY = "USERPASSWORD"
let USERPHONEKEY = "USERPHONE"



class HDUserDefaults: NSObject {

    static func hd_set(object:Any,forKey:String) {
//        HDStorageDao.dao().insertOrUpdate(key: forKey, value: object)
//        UserDefaults.standard.set(object, forKey: forKey)
//        UserDefaults.standard.synchronize()
    }
    
   static func hd_getObject(forKey:String) -> String? {
//        let object = UserDefaults.standard.object(forKey: forKey)
//    let object = HDStorageDao.dao().getValueBy(key: forKey)
//        if object != nil {
//            return (object as! String)
//        }
        return nil
    }
    
    static func hd_add(object:String,forKey:String) {
        if object.isEmpty {
            return
        }
        
        if forKey.isEmpty {
            return
        }
        
//        if let object:String = HDUserDefaults.hd_getObject(forKey: forKey) {
//            var array = objects.filter {$0 != object}
//            if array.count >= 3 && forKey == HDUSERNAMELOGINED{
//                array.removeLast()
//            }
//            array.insert(object, at: 0)
//            hd_set(object: array, forKey: forKey)
//        }else {
//            let objects:[String] = [object]
//            hd_set(object:objects, forKey: forKey)
//        }
            hd_set(object:object, forKey: forKey)
    }
    
    static func hd_getCurrentUser() -> String?{
        return HDUserDefaults.hd_getObject(forKey: USERPHONEKEY)
    }
    
    static func hd_deleteObject(forKey:String) {
        if forKey.isEmpty {
            return
        }
//        HDStorageDao.dao().delete(key: forKey)
//        UserDefaults.standard.removeObject(forKey: forKey)
    }
    
}

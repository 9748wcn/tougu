//
//  HDKeyChainHelper.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/10.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit

class HDKeyChainHelper: NSObject {
   
    class func getKeychainQuery(service:String) -> NSMutableDictionary {
        return NSMutableDictionary.init(dictionary: [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : service,
            kSecAttrAccessible : kSecAttrAccessibleAfterFirstUnlock
            ])
    }
    
    class func save(service:String,data:Any) {
        //Get search dictionary
        let keychainQuery = getKeychainQuery(service: service)
        //Delete old item before add new item
        SecItemDelete(keychainQuery)
        //Add new object to search dictionary(Attention:the data format)
        keychainQuery.setValue(NSKeyedArchiver.archivedData(withRootObject: data), forKey: kSecValueData as String)
        let saveState = SecItemAdd(keychainQuery, nil)
        if saveState == noErr {
            
        }
    }
    
    class func load(service:String) -> Any {
        var idObject:Any?
        let keychainQuery = getKeychainQuery(service: service)
        keychainQuery.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)
        keychainQuery.setValue(kSecMatchLimitOne, forKey: kSecMatchLimit as String)
        // 创建获取数据的引用
        var queryResult: AnyObject?
        // 通过查询是否存储在数据
        let readStatus = withUnsafeMutablePointer(to: &queryResult) { SecItemCopyMatching(keychainQuery, UnsafeMutablePointer($0))}
        if readStatus == errSecSuccess {
            if let data = queryResult as! NSData? {
                idObject = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as Any
            }
        }
        return idObject as Any
    }
    
}

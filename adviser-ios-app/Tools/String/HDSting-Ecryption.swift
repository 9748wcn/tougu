//
//  HDSting-Ecryption.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/11.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import Foundation
import CommonCrypto
//import CryptoSwift

extension String {
    
    func sha256(salt:String, iterations:Int, completeHandler:@escaping (String) -> Void)
{
        
        DispatchQueue.global(qos: .default).async {
            //处理耗时操作的代码块...
            var password = self + salt
            var count = iterations
            while count > 0 {
                password = password.sha256()
                count = count-1
            }
            //操作完成，调用主线程来刷新界面
            DispatchQueue.main.async {
                completeHandler(password)
            }
        }
    }
    
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }

    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }

    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)

        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }

        return hexString
    }
    
}

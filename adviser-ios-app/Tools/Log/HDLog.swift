//
//  HDLog.swift
//  mgr-combat-map-ios
//
//  Created by chenwuqi on 2019/5/17.
//  Copyright © 2019 evergrande_caifu_manager. All rights reserved.
//

import UIKit

func HDLog<T>(_ message : T, file : String? = #file, lineNumber : UInt? = #line) {
    
    #if DEBUG
    
    let fileName = (file! as NSString).lastPathComponent
    print("[\(fileName):line:\(lineNumber!)]- \(message)")
    
    #endif
}


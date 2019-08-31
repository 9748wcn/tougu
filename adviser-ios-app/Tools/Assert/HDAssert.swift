//
//  HDAssert.swift
//  mgr-combat-map-ios
//
//  Created by chenwuqi on 2019/5/27.
//  Copyright © 2019 evergrande_caifu_manager. All rights reserved.
//

import Foundation


public func HDAssert(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = String(), file: String = #file, line: UInt = #line) {
    #if DEBUG
    if !condition() {
        HDLog(message(), file: file, lineNumber: line)
        abort()
    }
    #endif
}


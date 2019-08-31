//
//  NSObject-Extension.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/25.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import Foundation



extension NSObject
{
    // MARK:返回className
   public var className:String{
        get{
            let name =  type(of: self).description()
            if(name.contains(".")){
                return name.components(separatedBy: ".")[1];
            }else{
                return name;
            }
            
        }
    }

}


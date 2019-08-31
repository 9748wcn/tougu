//
//  HDHudManager.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/11.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit

class HDHudManager: NSObject {
    static let shared = HDHudManager()
    var isActivity = false
    
    var window: UIWindow {
        let window:UIWindow = UIApplication.shared.keyWindow!
        return window
    }
    
    func show() {
        //操作完成，调用主线程来刷新界面
        DispatchQueue.main.async {
            if !self.isActivity {
                let hud:MBProgressHUD = MBProgressHUD.showAdded(to: self.window, animated: true)
                hud.removeFromSuperViewOnHide = true
                self.isActivity = true
            }
        }
        
    }
    
    func hide() {
        //立刻隐藏HUD窗口
        DispatchQueue.main.async {
            self.isActivity = false
            MBProgressHUD.hide(for: self.window, animated: true)
        }
        
    }
}

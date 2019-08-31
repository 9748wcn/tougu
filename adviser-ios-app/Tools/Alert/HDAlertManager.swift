//
//  HDAlert.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/13.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit

let hdSharedAlertManager = HDAlertManager()
class HDAlertManager {
    lazy var contents = [HDAlertBaseView]()
//    lazy var alertWindow: HDAlertWindow = {
//        let alert = HDAlertWindow.init()
//        alert.customInit()
//        return alert
//    }()
    var alertWindow: HDAlertWindow?
    
    func addContentView(contentView:HDAlertBaseView) {
        if contents.count > 0 {
            contentView.status = HDAlertViewStatus.waiting
        }
        contents.append(contentView)
    }
    
    func removeContentView(contentView:HDAlertBaseView) {
        if contents.count > 0 {
            let array = contents.filter {$0 != contentView}
            contents = array
        }
        if self.contents.count > 0 {
            show()
        }
    }
    
    func show() {
        if contents.count == 0 {
            return
        }
        let view = contents.first!
        if view.status == HDAlertViewStatus.running || view.status == HDAlertViewStatus.ending {
            return
        }
        view.status = HDAlertViewStatus.running
        if alertWindow == nil {
            alertWindow = HDAlertWindow.init()
            alertWindow?.customInit()
        }
        alertWindow?.contentContainerView = view
        alertWindow?.showWithAnimation()
    }
    
    func dismiss() {
        alertWindow?.dismissWithAnimation {
            [weak self] in
            if let strongSelf = self {
                let view = strongSelf.contents.first!
                view.status = HDAlertViewStatus.ending
                view.removeFromSuperview()
                strongSelf.removeContentView(contentView: view)
                strongSelf.alertWindow = nil
            }
        }
    }
}

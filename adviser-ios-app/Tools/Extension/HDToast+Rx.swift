//
//  HDToast+Rx.swift
//  mgr-combat-map-ios
//
//  Created by HDCF003 on 2019/8/6.
//  Copyright © 2019 evergrande_caifu_manager. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: HDToast {
    
    static var state: Binder<UIState> {
        return Binder(UIApplication.shared) { _, state in
            switch state {
            case .idle:
                break
            case .loading:
                 break
            case .success(let info):
                if let info = info {
                    HDToast.showTextToast(message: info)
                }
            case .failure(let info):
                if let info = info {
                    HDToast.showTextToast(message: info)
                }
            }
        }
    }
}

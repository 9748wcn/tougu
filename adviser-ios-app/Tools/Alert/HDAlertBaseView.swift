//
//  HDAlertBaseView.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/13.
//  Copyright © 2019 Chen Nate. All rights reserved.
//
import RxCocoa
import RxSwift
import UIKit

@objc protocol HDAlertViewDelegate {
//    @objc optional func alertShow()
//    @objc optional func alertDismiss()
    @objc optional func alertClick(index:Int)
}
// 定义枚举
enum HDAlertViewStatus {
    case ready
    case ending
    case waiting
    case running
}
class HDAlertBaseView: UIView {
    var status = HDAlertViewStatus.ready
    weak var delegate:HDAlertViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8;
    }
}

class RxHDAlertViewDelegateProxy : DelegateProxy<HDAlertBaseView, HDAlertViewDelegate>,
    DelegateProxyType,
HDAlertViewDelegate {
    init(parentObject: HDAlertBaseView) {
        super.init(parentObject: parentObject, delegateProxy: RxHDAlertViewDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register{ RxHDAlertViewDelegateProxy(parentObject: $0) }
    }
    
    static func currentDelegate(for object: HDAlertBaseView) -> HDAlertViewDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: HDAlertViewDelegate?, to object: HDAlertBaseView) {
        object.delegate = delegate
    }
}
extension Reactive where Base: HDAlertBaseView {
    //代理委托
    var delegate: DelegateProxy<HDAlertBaseView, HDAlertViewDelegate> {
        return RxHDAlertViewDelegateProxy.proxy(for: base)
    }
    
    var clickIndex:ControlEvent<Int>{
        let source:Observable<Int> = self.delegate.methodInvoked(#selector(HDAlertViewDelegate.alertClick(index:))).map({ a in
            return try castOrThrow(Int.self, a[0])
            })
        return  ControlEvent(events: source)
    }
}

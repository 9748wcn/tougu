//
//  ASUmengshareView.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/11.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

protocol ASShareClickDelegate: NSObjectProtocol {
    
    func wechatShareClick()
    func wechatFrendsShareClick()
    func QQShareClick()
}

class ASUmengshareView: UIView,buttonClickDelegate {
    
    let tap = UITapGestureRecognizer()
    var isShowing: Bool = false
    var isTabbar: Bool = false
    
    
    weak var shareDelegate: ASShareClickDelegate!
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        self.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        tap.addTarget(self, action: #selector(dissmiss))
        self.addGestureRecognizer(tap)
        self.addSubview(alertBottomView)
        alertBottomView.delegate = self
        
    }
    
    private lazy var alertBottomView: shareBottomAlertView = {
        let alertBottomView = shareBottomAlertView.loadFromXib()
        alertBottomView.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: 177)
        return alertBottomView as! shareBottomAlertView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dissmiss() {
        isShowing = false
        UIView.animate(withDuration: 0.25, animations: {
            var frame = self.alertBottomView.frame
            frame.origin.y = screenHeight
            self.alertBottomView.frame = frame
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
        
    }
    
    public func showInView (bgView: UIView) {
        if isShowing {
            return
        }
        isShowing = true
        bgView.addSubview(self)
        UIView.animate(withDuration: 0.25, animations: {
            var frame = self.alertBottomView.frame
            frame.origin.y = screenHeight - (177 + bottomSafeHeight + (self.isTabbar ? 49 : 0))
            self.alertBottomView.frame = frame
        }) { (_) in
            
        }
    }
    
    func butonClickBy(_ sender: UIButton) {
        
        if sender.tag == 10001 {
            dissmiss()
        }else if sender.tag == 10002 {//微信
            shareDelegate.wechatShareClick()
        }else if sender.tag == 10003 {//朋友圈
            shareDelegate.wechatFrendsShareClick()
        }else if sender.tag == 10004 {//QQ
            shareDelegate.QQShareClick()
        }
    }


}

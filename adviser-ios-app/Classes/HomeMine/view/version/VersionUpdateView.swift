//
//  VersionUpdateView.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/25.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class VersionUpdateView: UIView, buttonClickDelegate {
    
    private lazy var contentView: UpdateAlertView = UpdateAlertView.loadFromXib()
    fileprivate var contentViewHight: CGFloat {
        return contentView.getUpdateViewHeight()
    }
    var isforce: Bool = false {
        didSet {
            contentView.isforce = isforce
        }
    }
    var versionValue: String = "" {
        didSet {
            contentView.versionValue = versionValue
        }
    }
    var delegate: UpdateViewDelegate!
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(contents: Array<String>) {
        self.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.addSubview(contentView)
        contentView.contentArray = contents
        contentView.delegate = self
        contentView.frame = CGRect(x: (screenWidth - 300)/2.0, y: screenHeight, width: 300, height: contentViewHight)
    }
    
    func show()  {
        if let window = appDelegate.window {
            window.addSubview(self)
        }
        var frame = contentView.frame
        if self.contentView.frame.origin.y <= screenHeight {
            frame.origin.y = (screenHeight - frame.height) * 0.5
            UIView.animate(withDuration: 0.25) {
                self.contentView.frame = frame
            }
        }
    }
    fileprivate func removeSelfFromSupView() {
        var frame = self.contentView.frame
        frame.origin.y = screenHeight
        UIView.animate(withDuration: 0.25, animations: {
            self.contentView.frame = frame
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    func butonClickBy(_ sender: UIButton) {
        if sender.tag == 1000 { //取消更新
            removeSelfFromSupView()
        }else { //更新
            self.delegate.updateVersion(sender)
            removeSelfFromSupView()
        }
    }

}

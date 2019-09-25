//
//  businessCardCommitAlertView.swift
//  adviser-ios-app
//
//  Created by HDCF003 on 2019/9/19.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class BusinessCardCommitAlertView: UIView {

    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 4
        return view
    }()
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(rgb: 0xE7E8EB)
        return line
    }()
    private lazy var titleL: UILabel = {
        let label =  UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(rgb: 0x27314A)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    private lazy var scureBnt: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleColor(UIColor(rgb: 0x497BEC), for: .normal)
        btn.setTitle("确定", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        return btn
    }()
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(content:String) {
        self.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        self.addSubview(bgView)
        bgView.addSubview(titleL)
        bgView.addSubview(line)
        bgView.addSubview(scureBnt)
        
        let height = content.obtainTextHeight(font: UIFont.systemFont(ofSize: 16), fixedWidth: screenWidth - 53.0 * 2.0 - 50)
        bgView.frame = CGRect(x: 53, y: screenHeight, width: screenWidth - 53.0 * 2.0, height: 85 + height)
        titleL.frame = CGRect(x: 25, y: 17, width: bgView.W - 50, height: height)
        
        scureBnt.frame = CGRect(x: 0, y: bgView.H - 44, width: bgView.W, height: 44)
        line.frame = CGRect(x: 0, y: scureBnt.Y - 1, width: scureBnt.W, height: 1)
        
        titleL.text = content
    }
    
    @objc func btnClicked(_ btn:UIButton) {
        removeSelfFromSupView()
    }
    
    func show()  {
        if let window = appDelegate.window {
            window.addSubview(self)
        }
        var frame = bgView.frame
        if self.bgView.frame.origin.y <= screenHeight {
            frame.origin.y = (screenHeight - frame.height) * 0.5
            UIView.animate(withDuration: 0.25) {
                self.bgView.frame = frame
            }
        }
    }
    fileprivate func removeSelfFromSupView() {
        var frame = self.bgView.frame
        frame.origin.y = screenHeight
        UIView.animate(withDuration: 0.25, animations: {
            self.bgView.frame = frame
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
}

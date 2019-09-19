//
//  UpdateViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

protocol UpdateViewDelegate: NSObjectProtocol {
    
    func updateVersion(_ sender: UIButton)
}

class UpdateViewController: UIViewController, buttonClickDelegate {
    
    var cellTitleList:Array<String>?
    var delegate: UpdateViewDelegate!
    
    
    fileprivate var updateContentView: UpdateAlertView = UpdateAlertView.loadFromXib()
    fileprivate var overVeiw = UIView()
    fileprivate var contentViewHight: CGFloat {
        return updateContentView.getUpdateViewHeight()
    }
    
    var isforce: Bool = false {
        didSet {
            updateContentView.isforce = isforce
        }
    }
    
    
    required init?(cellContent: [String]?) {
        super.init(nibName: nil, bundle: nil)
        // 初始化
        self.cellTitleList = cellContent;
        
        view.backgroundColor = UIColor.clear
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .custom
        
        // 初始化UI
        setupUIViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.25) {
            var frame = self.updateContentView.frame
            frame.origin.y = (kScreenHeight-self.contentViewHight)/2.0
            self.updateContentView.frame = frame
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupContentViewData() {
        
    }

}

extension UpdateViewController {
    func setupUIViews() {
        overVeiw =
            UIView(frame: CGRect(x: 0, y: 0, width:kScreenWidth, height: kScreenHeight))
        overVeiw.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(overVeiw)
        updateContentView.contentArray = cellTitleList //先设置内容才能获取高度
        updateContentView.delegate = self
        updateContentView.frame = CGRect(x: (screenWidth - 300)/2.0, y: screenHeight, width: 300, height: contentViewHight)
        
        overVeiw.addSubview(updateContentView)
        
    }
    
    func sheetViewDismiss() {
        UIView.animate(withDuration: 0.25, animations: {
            var frame = self.updateContentView.frame
            frame.origin.y = kScreenHeight
            self.updateContentView.frame = frame
            self.overVeiw.alpha = 0
            
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func butonClickBy(_ sender: UIButton) {
        if sender.tag == 1000 { //取消更新
            sheetViewDismiss()
        }else { //更新
            self.delegate.updateVersion(sender)
        }
    }
}

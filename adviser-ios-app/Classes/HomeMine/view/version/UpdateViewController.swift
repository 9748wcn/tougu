//
//  UpdateViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {
    
    var cellTitleList:Array<String>?
    
    fileprivate var updateContentView: UpdateAlertView = UpdateAlertView.loadFromXib()
    fileprivate var overVeiw = UIView()
    fileprivate var contentViewHight: CGFloat {
        if cellTitleList != nil {
            return CGFloat((cellTitleList!.count) * 15 + 280)
        }else {
            return 280
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
        updateContentView.frame = CGRect(x: (screenWidth - 290)/2.0, y: screenHeight, width: 290, height: contentViewHight)
        updateContentView.contentArray = cellTitleList
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sheetViewDismiss()
    }
}

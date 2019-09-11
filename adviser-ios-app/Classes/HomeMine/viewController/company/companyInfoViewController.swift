//
//  companyInfoViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/9.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class companyInfoViewController: baseViewController,ASShareClickDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "公司对外信息"
        // Do any additional setup after loading the view.
        let shareItem = UIBarButtonItem(image: UIImage(named: "shareIcon"), style: .plain, target: self, action: #selector(shareItemClicked))
//        let shareItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelItemClicked))
        navigationItem.rightBarButtonItem = shareItem
    }
    
    @objc private func shareItemClicked() {
        let shareView:ASUmengshareView = ASUmengshareView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        shareView.shareDelegate = self
        shareView.showInView(bgView: view)
        
//        UMSocialUIManager.showShareMenuViewInWindow { (UMSocialPlatformType, [AnyHashable : Any]?) in
//
//        }
    }

    func wechatShareClick() {
        let messegeObject: UMSocialMessageObject = UMSocialMessageObject.init()
//        let shareObject = UMShareObject.shareObject(withTitle: "haha", descr: "hahahahha", thumImage: nil)
//        messegeObject.shareObject = shareObject
        messegeObject.text = "随便写"
        UMSocialManager.default()?.share(to: UMSocialPlatformType.wechatSession, messageObject: messegeObject, currentViewController: self, completion: { (data: Any, err: Error) in
            
            } as? UMSocialRequestCompletionHandler)
    }
    
    func wechatFrendsShareClick() {
        
    }
    
    func QQShareClick() {
        let messegeObject: UMSocialMessageObject = UMSocialMessageObject.init()
        messegeObject.text = "随便写"
        UMSocialManager.default()?.share(to: UMSocialPlatformType.QQ, messageObject: messegeObject, currentViewController: self, completion: { (data: Any, err: Error) in
            
            } as? UMSocialRequestCompletionHandler)
    }

}

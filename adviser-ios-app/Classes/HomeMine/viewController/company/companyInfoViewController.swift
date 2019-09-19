//
//  companyInfoViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/9.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import WebKit

class companyInfoViewController: baseViewController,ASShareClickDelegate {
    
    var webView: WKWebView!
    
    var url: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "公司对外信息"
        // Do any additional setup after loading the view.
        let shareItem = UIBarButtonItem(image: UIImage(named: "shareIcon"), style: .plain, target: self, action: #selector(shareItemClicked))
        navigationItem.rightBarButtonItem = shareItem
        
        webView = WKWebView(frame: self.view.frame)
        // 下面一行代码意思是充满的意思(一定要加，不然也会显示有问题)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        self.view.addSubview(webView)
        let mapwayURL = URL(string: url)!
        let mapwayRequest = URLRequest(url: mapwayURL)
        webView.load(mapwayRequest)
    }
    
    @objc private func shareItemClicked() {
        let shareView:ASUmengshareView = ASUmengshareView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        shareView.shareDelegate = self
        shareView.showInView(bgView: view)
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

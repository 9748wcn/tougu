//
//  companyInfoViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/9.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import WebKit

class CompanyInfoViewController: BaseViewController,ASShareClickDelegate {
    
    var webView: WKWebView!
    
    var url: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "公司对外信息"
        // Do any additional setup after loading the view.
        let shareItem = UIBarButtonItem(image: UIImage(named: "shareIcon"), style: .plain, target: self, action: #selector(shareItemClicked))
        navigationItem.rightBarButtonItem = shareItem
        url = "http://172.24.19.45:8080/#/hdIfon"
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
        let messegeObject: UMSocialMessageObject = UMSocialMessageObject()
        let shareObjext: UMShareWebpageObject = UMShareWebpageObject.shareObject(withTitle: "恒大金融财富管理（深圳）有限公司简介", descr: "值得信赖的财富管理平台", thumImage: UIImage(named: "appIcon"))
//        let defaultStand = UserDefaults.standard
//        let phoneNo = defaultStand.string(forKey: USERPHONEKEY)
        shareObjext.webpageUrl = "http://172.24.19.45:8080/#/hdIfon"
        messegeObject.shareObject = shareObjext
        
        //        messegeObject.webpageUrl = ""
        
        UMSocialManager.default()?.share(to: UMSocialPlatformType.wechatSession, messageObject: messegeObject, currentViewController: self, completion: { (data: Any, err: Error) in
            
            } as? UMSocialRequestCompletionHandler)
    }
    
    func wechatFrendsShareClick() {
        
        let messegeObject: UMSocialMessageObject = UMSocialMessageObject()
        let shareObjext: UMShareWebpageObject = UMShareWebpageObject.shareObject(withTitle: "恒大金融财富管理（深圳）有限公司简介", descr: "值得信赖的财富管理平台", thumImage: UIImage(named: "appIcon"))
        //        let defaultStand = UserDefaults.standard
        //        let phoneNo = defaultStand.string(forKey: USERPHONEKEY)
        shareObjext.webpageUrl = "http://172.24.19.45:8080/#/hdIfon"
        messegeObject.shareObject = shareObjext
        
        //        messegeObject.webpageUrl = ""
        
        UMSocialManager.default()?.share(to: UMSocialPlatformType.wechatTimeLine, messageObject: messegeObject, currentViewController: self, completion: { (data: Any, err: Error) in
            
            } as? UMSocialRequestCompletionHandler)
    }
    
    func QQShareClick() {
        let messegeObject: UMSocialMessageObject = UMSocialMessageObject()
        let shareObjext: UMShareWebpageObject = UMShareWebpageObject.shareObject(withTitle: "恒大金融财富管理（深圳）有限公司简介", descr: "值得信赖的财富管理平台", thumImage: UIImage(named: "appIcon"))
        //        let defaultStand = UserDefaults.standard
        //        let phoneNo = defaultStand.string(forKey: USERPHONEKEY)
        shareObjext.webpageUrl = "http://172.24.19.45:8080/#/hdIfon"
        messegeObject.shareObject = shareObjext
        
        //        messegeObject.webpageUrl = ""
        
        UMSocialManager.default()?.share(to: UMSocialPlatformType.QQ, messageObject: messegeObject, currentViewController: self, completion: { (data: Any, err: Error) in
            
            } as? UMSocialRequestCompletionHandler)
    }

}

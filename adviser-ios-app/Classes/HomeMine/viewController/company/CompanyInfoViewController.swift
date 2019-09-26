//
//  companyInfoViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/9.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import WebKit

class CompanyInfoViewController: BaseViewController,ASShareClickDelegate,WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate {
    
    private var _url : String?
    var url : String? {
        set {
            _url = newValue
            if newValue == nil {return}
            let request = URLRequest(url: URL(string: newValue!)!)
            self.webView.load(request)
        }
        get {
            return _url
        }
    }
    
    /// 添加进度条
    lazy private var progressView: UIProgressView = {
        self.progressView = UIProgressView.init(frame: CGRect(x: CGFloat(0), y: navHeight, width: UIScreen.main.bounds.width, height: 2))
        self.progressView.tintColor = main_buttonColor      // 进度条颜色
        self.progressView.trackTintColor = UIColor.white // 进度条背景色
        return self.progressView
    }()
    
//    var webView: WKWebView!
    
//    var url: String!
    
    lazy var webView: WKWebView = {
        let webView = WKWebView.init(frame: view.bounds)
        webView.scrollView.bounces = false
        webView.uiDelegate = self
        webView.navigationDelegate = self
        // 下面一行代码意思是充满的意思(一定要加，不然也会显示有问题)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
        view.addSubview(self.progressView)
        view.bringSubviewToFront(self.progressView) // 将进度条至于最顶层
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        return webView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "公司对外信息"
        // Do any additional setup after loading the view.
        let shareItem = UIBarButtonItem(image: UIImage(named: "shareIcon"), style: .plain, target: self, action: #selector(shareItemClicked))
        navigationItem.rightBarButtonItem = shareItem
//        url = companyShareUrl
//        webView = WKWebView(frame: self.view.frame)
//
        
        
        
//        self.view.addSubview(webView)
//        let mapwayURL = URL(string: url)!
//        let mapwayRequest = URLRequest(url: mapwayURL)
//        webView.load(mapwayRequest)
    }

    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //  加载进度条
        if keyPath == "estimatedProgress"{
            progressView.alpha = 1.0
//            print(self.webView.estimatedProgress)
            progressView.setProgress(Float((self.webView.estimatedProgress) ), animated: true)
            if (self.webView.estimatedProgress )  >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
    
    
    @objc private func shareItemClicked() {
        let shareView:ASUmengshareView = ASUmengshareView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        shareView.shareDelegate = self
        shareView.showInView(bgView: view)
    }

    func wechatShareClick() {
        let messegeObject: UMSocialMessageObject = UMSocialMessageObject()
        let shareObjext: UMShareWebpageObject = UMShareWebpageObject.shareObject(withTitle: "恒大金融财富管理（深圳）有限公司简介", descr: "值得信赖的财富管理平台", thumImage: UIImage(named: "appIcon"))
        shareObjext.webpageUrl = companyShareUrl
        messegeObject.shareObject = shareObjext
        UMSocialManager.default()?.share(to: UMSocialPlatformType.wechatSession, messageObject: messegeObject, currentViewController: self, completion: { (data: Any, err: Error) in
            
            } as? UMSocialRequestCompletionHandler)
    }
    
    func wechatFrendsShareClick() {
        
        let messegeObject: UMSocialMessageObject = UMSocialMessageObject()
        let shareObjext: UMShareWebpageObject = UMShareWebpageObject.shareObject(withTitle: "恒大金融财富管理（深圳）有限公司简介", descr: "值得信赖的财富管理平台", thumImage: UIImage(named: "appIcon"))
        //        let defaultStand = UserDefaults.standard
        //        let phoneNo = defaultStand.string(forKey: USERPHONEKEY)
        shareObjext.webpageUrl = companyShareUrl
        messegeObject.shareObject = shareObjext
        
        //        messegeObject.webpageUrl = ""
        
        UMSocialManager.default()?.share(to: UMSocialPlatformType.wechatTimeLine, messageObject: messegeObject, currentViewController: self, completion: { (data: Any, err: Error) in
            
            } as? UMSocialRequestCompletionHandler)
    }
    
    func QQShareClick() {
        let messegeObject: UMSocialMessageObject = UMSocialMessageObject()
        let shareObjext: UMShareWebpageObject = UMShareWebpageObject.shareObject(withTitle: "恒大金融财富管理（深圳）有限公司简介", descr: "值得信赖的财富管理平台", thumImage: UIImage(named: "appIcon"))
        shareObjext.webpageUrl = companyShareUrl
        messegeObject.shareObject = shareObjext
        UMSocialManager.default()?.share(to: UMSocialPlatformType.QQ, messageObject: messegeObject, currentViewController: self, completion: { (data: Any, err: Error) in
            
            } as? UMSocialRequestCompletionHandler)
    }
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
        self.webView.uiDelegate = nil
        self.webView.navigationDelegate = nil
        print("释放啦")
    }
}

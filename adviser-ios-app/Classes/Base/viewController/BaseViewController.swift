//
//  baseViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/8/31.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController == nil {
            return
        }
        if navigationController?.navigationBar.isHidden ?? true {
            return
        }
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(popBack))
        self.navigationItem.backBarButtonItem = item
        let backImage = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal);
        navigationController?.navigationBar.backIndicatorImage = backImage;
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage;
    }
    
    @objc  func popBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func refreshRequest() {
        
    }
    func hd_push(vc:BaseViewController, animation:Bool) {
//        HDHomeNavgationBarManager.share.currentViewController = vc
//        if animation {
//            self.addChild(vc)
//            self.view.addSubview(vc.view)
//            vc.view.snp.makeConstraints { (make) in
//                make.top.left.right.bottom.equalTo(self.view)
//            }
//            let transform = CATransform3DTranslate(CATransform3DIdentity, screenWidth, 0, 0)
//            vc.view.layer.transform = transform
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .transitionFlipFromRight, animations: {
//                vc.view.layer.transform = CATransform3DIdentity
//            }, completion: nil)
//            
//        }else {
//            self.addChild(vc)
//            self.view.addSubview(vc.view)
//            vc.view.snp.makeConstraints { (make) in
//                make.top.left.right.bottom.equalTo(self.view)
//            }
//        }
    }
    
    func hd_pop(animation:Bool) {
//        if let vc:baseViewController = self.parent as? HDBaseViewController {
//            HDHomeNavgationBarManager.share.setNavigation(title: vc.navTitle)
//            HDHomeNavgationBarManager.share.currentViewController = vc
//        }
//        if animation {
//            UIView.animate(withDuration: 0.5, animations: {
//                let transform = CATransform3DTranslate(CATransform3DIdentity, screenWidth, 0, 0)
//                self.view.layer.transform = transform
//            }) { (finish) in
//                self.willMove(toParent: self.parent)
//                self.view.removeFromSuperview()
//                self.didMove(toParent: self.parent)
//                self.removeFromParent()
//            }
//        }else {
//            self.willMove(toParent: self.parent)
//            self.view.removeFromSuperview()
//            self.didMove(toParent: self.parent)
//            self.removeFromParent()
//        }
    }
    //控制器添加导航栏
//    func setupNav()->UINavigationController {
//        let nav:UINavigationController = UINavigationController.init(rootViewController: self)
//        nav.navigationBar.setBackgroundImage(imageFromColor(color: UIColor.white), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
//        nav.navigationBar.shadowImage = UIImage()
//        return nav;
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    deinit {
        print("-[\(self.className)] dealloc")
    }

}

//
//  AppDelegate.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/8/29.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CLToast


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "完成"
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.toolbarManageBehaviour = .byPosition
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let defaultStand = UserDefaults.standard
        if (defaultStand.string(forKey: USERPHONEKEY) != nil) {
            gotoMainVC()
        }else {
            gotoLogin()
        }
        configShared()
        //版本检测
//        let versionManager = VersionValueManager()
//        versionManager.isShowHub = false
//        versionManager.getVersionValue(vc: window!.rootViewController!)
        
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        CLToastManager.share.cancelAll()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let result = UMSocialManager.default()?.handleOpen(url, options: options)
        
        return result!
        
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let result = UMSocialManager.default()?.handleOpen(url, sourceApplication: sourceApplication, annotation: annotation)
        
        return result!
    }


}

extension AppDelegate{
    func gotoMainVC() {
        let mainVC  = HomeTabbarViewController()
        window?.rootViewController = mainVC
    }
    
    func gotoLogin() {
        //清空信息，跳转到登录界面
        let defaultStand = UserDefaults.standard
        defaultStand.removeObject(forKey: USERPHONEKEY)
        defaultStand.removeObject(forKey: USERICNO)
        defaultStand.removeObject(forKey: USERNAMEKEY)
        defaultStand.removeObject(forKey: USERJOBKEY)
        defaultStand.removeObject(forKey: USERTOKENKEY)
        let loginVC = HomeLoginViewController()
        let navLogin = BaseNavigationViewController.init(rootViewController: loginVC)
        window?.rootViewController = navLogin
        
    }
}

extension AppDelegate {
    func configShared() {
        let shareManager: UmengShareManager = UmengShareManager.sharedInstance
        shareManager.configUSharePlatforms()
    }
}


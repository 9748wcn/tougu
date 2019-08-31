//
//  baseTabbarController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/8/31.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class baseTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addChildViewControllers()
        tabBar.tintColor = UIColor(red: 9/255.0, green: 187/255.0, blue: 7/255.0, alpha: 1)
    }
    
    public func addChildViewControllers() {
        
    }

    public func setupOneChildViewController(_ title: String, image: String, selectedImage: String, controller: UIViewController) {
        controller.tabBarItem.title = title
        controller.title = title
        controller.view.backgroundColor = UIColor.white
        controller.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        let nav = UINavigationController.init(rootViewController: controller)
        addChild(nav)
    }

}

//
//  HomeTabbarViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/8/31.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class HomeTabbarViewController: baseTabbarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func addChildViewControllers() {
        self.setupOneChildViewController("首页", image: "mainUnSelected", selectedImage: "mainSelected", controller: HomeMineShareCardViewController())
        self.setupOneChildViewController("我的", image: "mineUnSelected", selectedImage: "mineSelected", controller: HomeMineViewController())
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

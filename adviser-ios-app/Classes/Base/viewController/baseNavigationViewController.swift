//
//  baseNavigationViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/2.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class baseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupNavigationBarAppearance()

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
//    func setupNavigationBarAppearance() {
//        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//        self.navigationItem.backBarButtonItem = item;
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

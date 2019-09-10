//
//  companyInfoViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/9.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class companyInfoViewController: baseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "公司对外信息"
        // Do any additional setup after loading the view.
        let shareItem = UIBarButtonItem(image: UIImage(named: "shareIcon"), style: .plain, target: self, action: #selector(shareItemClicked))
//        let shareItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelItemClicked))
        navigationItem.rightBarButtonItem = shareItem
    }
    
    @objc private func shareItemClicked() {
        UMSocialUIManager.showShareMenuViewInWindow { (UMSocialPlatformType, [AnyHashable : Any]?) in
            
        }
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

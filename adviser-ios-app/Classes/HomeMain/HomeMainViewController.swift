//
//  HomeMainViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/8/31.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class HomeMainViewController: baseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
        
        let button: HDCustomBution = HDCustomBution()
        button.setupConfig(radius: 3.0, borderW: 1.0, borderC: UIColor.white.cgColor, defaultColor: UIColor.green)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 45)
        button.setTitle("点击到编辑", for: .normal)
        button.addTarget(self, action: #selector(gotoVC), for: .touchUpInside)
        view.addSubview(button)
        
        let button2: HDCustomBution = HDCustomBution()
        button2.setupConfig(radius: 3.0, borderW: 1.0, borderC: UIColor.white.cgColor, defaultColor: UIColor.green)
        button2.frame = CGRect(x: 100, y: 300, width: 100, height: 45)
        button2.setTitle("点击到登录", for: .normal)
        button2.addTarget(self, action: #selector(gotoLogin), for: .touchUpInside)
        view.addSubview(button2)
        
    }
    
    @objc func gotoVC() {
        let vc:businessCardEditViewController = businessCardEditViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func gotoLogin() {
        let vc: HomeLoginViewController = HomeLoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
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

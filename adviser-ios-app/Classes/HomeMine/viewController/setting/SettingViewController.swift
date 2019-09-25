//
//  SettingViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/10.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - navHeight), style: .plain)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = background_Color
        tableView.hx_registerCell(cellClass: UITableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        return tableView
        
    }()
    
    let contentArray: Array<String> = ["重置密码"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "设置"
        view.addSubview(tableView)
        
    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = contentArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 105))
        footView.backgroundColor = background_Color
        let logOutBtn: HDCustomBution = HDCustomBution()
        logOutBtn.setupConfig(radius: 22.5, borderW: 1.0, borderC: main_buttonColor.cgColor, defaultColor: UIColor.white, selectColor: UIColor.white)
        logOutBtn.setTitle("安全退出", for: .normal)
        logOutBtn.setTitleColor(main_buttonColor, for: .normal)
        logOutBtn.frame = CGRect(x: 15, y: 30, width: view.bounds.width - 30, height: 45)
        logOutBtn.addTarget(self, action: #selector(logoutBtnClick), for: .touchUpInside)
        footView.addSubview(logOutBtn)
        return footView
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let setVC:ResetPassWordVerifyViewController = ResetPassWordVerifyViewController()
        setVC.isfromLoginVC = false
        self.navigationController?.pushViewController(setVC, animated: true)
    }
}

// MRAK -methods

extension SettingViewController {
    
    //退出登录
    @objc func logoutBtnClick() {
//        let defaultStand = UserDefaults.standard
//        LogoutSystemManager().logoutSystem(vc: self, phoneNo: defaultStand.string(forKey: USERPHONEKEY)!)
        appDelegate.gotoLogin()
    }
    
    func logoutSeccuss() {
//        let defaultStand = UserDefaults.standard
//        defaultStand.removeObject(forKey: USERPHONEKEY)
//        defaultStand.removeObject(forKey: USERICNO)
//        defaultStand.removeObject(forKey: USERNAMEKEY)
//        defaultStand.removeObject(forKey: USERJOBKEY)
//        let vc: HomeLoginViewController = HomeLoginViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}

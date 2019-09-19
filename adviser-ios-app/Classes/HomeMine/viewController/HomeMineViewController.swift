//
//  HomeMineViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/8/31.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class HomeMineViewController: baseViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .plain)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = HomeBackground_Color
        tableView.hx_registerCell(cellClass: HomeMineTableViewCell.self)
        return tableView
        
    }()
    
    var headerView: HomeMineHeadView!
    var personInfoModel: personInfoModel?
    
    
    
    let headImages: Array = ["infoImage","settingImage","versionImage"]
    let headTitles: Array = ["公司对外信息","设置","版本信息"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaultStand = UserDefaults.standard
        let phoneNo = defaultStand.string(forKey: USERPHONEKEY)
        PersonInfoGetValueManager.shared.getPersonInfo(vc: self, phoneNo: phoneNo!)
    }
    
    func updateHeaderInfo(model: personInfoModel) {
        self.headerView.updateUI(model: model)
        personInfoModel = model
    }

}

//
//  HomeMineShareCardViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/7.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class HomeMineShareCardViewController: BaseViewController {
    
    
    var isHiddenTabbar: Bool = false
    
    var sectionHeaderView: ShareCardHeaderView!
    
    var section0Value: String!
    var section1Values: Array<UserBehaviourItemModel>?
    var headerModel: ShareCardModel?
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: navHeight, width: view.bounds.width, height: view.bounds.height-52 - bottomSafeHeight - (isHiddenTabbar ? 0 : 49) - navHeight), style: .grouped)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.hx_registerCell(cellClass: ShareCardIntroduceCell.self)
        tableView.hx_registerCell(cellClass: RecordTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        return tableView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = isHiddenTabbar ? "名片转发" : "首页"
        let bottonView = bottomView()
        view.addSubview(bottonView)
        view.addSubview(tableView)
        let headerRefresh: ASRefreshHeader = ASRefreshHeader()
        headerRefresh.setRefreshingTarget(self, refreshingAction: #selector(refreshDate))
        tableView.mj_header = headerRefresh
        startGetData()
        section0Value = "为客户创造价值，为社会创造财富”，我来自恒大财富，我们致力于成为中国财富管理行业的卓越践行者与领跑者，为您的财富管理提供强而有力的支持。"
    }
    
    func bottomView() -> UIView {
        let bottonView: UIView = UIView.init()
        bottonView.frame = CGRect(x: 0, y: view.bounds.height - 52 - bottomSafeHeight - (isHiddenTabbar ? 0 : 49), width: view.bounds.width, height: 52)
        let editBtn: TabbarButton = TabbarButton.loadFromXib()
        bottonView.addSubview(editBtn)
        editBtn.imageButton.setImage(UIImage(named: "editCard"), for: .normal)
        editBtn.buttonNameLabel.text = "名片编辑"
        editBtn.frame = CGRect(x: view.bounds.width - 345, y: (52 - 38)/2.0, width: 50, height: 38)
        editBtn.imageButton.addTarget(self, action: #selector(editCardClick), for: .touchUpInside)
        let saveBtn: TabbarButton = TabbarButton.loadFromXib()
        bottonView.addSubview(saveBtn)
        saveBtn.imageButton.setImage(UIImage(named: "saveCard"), for: .normal)
        saveBtn.buttonNameLabel.text = "名片保存"
        saveBtn.imageButton.addTarget(self, action: #selector(saveCardClick(_:)), for: .touchUpInside)
        saveBtn.frame = CGRect(x: view.bounds.width - 345 + 50 + 50, y: (52 - 38)/2.0, width: 50, height: 38)
        let shareCardBtn: HDCustomBution = HDCustomBution()
        shareCardBtn.setupConfig(radius: 16.0, borderW: 1.0, borderC: UIColor(rgb: 0x497BEC).cgColor, defaultColor: UIColor(rgb: 0x497BEC), selectColor: UIColor(rgb: 0x497BEC))
        shareCardBtn.setTitle("分享名片链接", for: .normal)
        shareCardBtn.addTarget(self, action: #selector(shareCardClick), for: .touchUpInside)
        shareCardBtn.frame = CGRect(x: view.bounds.width - 130 - 15, y: 10, width: 130, height: 32)
        bottonView.addSubview(shareCardBtn)
        return bottonView
        
    }
    
    func delay(_ seconds: Double, completion:@escaping ()->()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
    @objc func refreshDate() {
        let defaultStand = UserDefaults.standard
        let phoneNo = defaultStand.string(forKey: USERPHONEKEY)
        ShareCardGetInfoManager().getemployeeInfo(vc: self, phoneNo: phoneNo!)
//        let versionManager = VersionValueManager()
//        versionManager.isShowHub = false
//        versionManager.getVersionValue(vc: self)
    }
    
    func gotoGetBehaviourInfo() {
        let defaultStand = UserDefaults.standard
        let phoneNo = defaultStand.string(forKey: USERPHONEKEY)
        UserBehaviourManager().getBehaviourInfo(vc: self, phoneNo: phoneNo!)
    }
    
    func startGetData() {
        tableView.mj_header.beginRefreshing()
        
    }
    
    func getDataFinish() {
        tableView.mj_header.endRefreshing()
        gotoGetBehaviourInfo()
    }

}

//
//  personInfoViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/6.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class personInfoViewController: baseViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .plain)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.hx_registerCell(cellClass: personInfoTableViewCell.self)
        return tableView
        
    }()
    let firstSectionKeys:Array = ["姓名","手机号","工号","职务"]
    var firstSectionValues:Array<String>?
    let secondSectionKeys:Array = ["所属团队","团队名称","团队类型"]
    var secondSectionValues:Array<String>?
    var headerBtn: UIButton!
    let disposeBag = DisposeBag()
    var dataModel:personInfoModel? {
        didSet {
            if dataModel?.data != nil {
                setupWithData(firstValueArray: [dataModel?.data?.employeeName,dataModel?.data?.phoneNo,dataModel?.data?.employeeNumber,dataModel?.data?.jobName], secondValueArray: [dataModel?.data?.parentGroupName,dataModel?.data?.groupName,dataModel?.data?.groupType])
            }
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "员工信息"
        view.addSubview(tableView)
        
//        let defaultStand = UserDefaults.standard
//        let phoneNo = defaultStand.string(forKey: USERPHONEKEY)
//        PersonInfoGetValueManager.shared.getPersonInfo(vc: self, phoneNo: phoneNo!)
        
    }
    
    func setupWithData(firstValueArray: [String?],secondValueArray: [String?]) {
        
        firstSectionValues = firstValueArray as? Array<String>
        secondSectionValues = secondValueArray as? Array<String>
        tableView.reloadData()
    }
    
    func uploadImage(image: UIImage) {
        let defaultStand = UserDefaults.standard
        UploadImageManager().uploadImage(vc: self, image: image, phoneNo: defaultStand.string(forKey: USERPHONEKEY)!)
    }

}

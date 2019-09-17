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
    let firstSectionValues:Array = ["张大海","150****5271","IC5016","初级投资顾问"]
    let secondSectionKeys:Array = ["所属团队","团队名称","团队类型"]
    let secondSectionValues:Array = ["恒大财富","上海电销团队","电销"]
    var headerBtn: UIButton!
    let disposeBag = DisposeBag()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "员工信息"
        view.addSubview(tableView)
    }

}

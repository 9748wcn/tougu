//
//  businessCardEditViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/8/31.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class businessCardEditViewController: baseViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - 50), style: .plain)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.hx_registerCell(cellClass: businessCardHeadCell.self)
        tableView.hx_registerCell(cellClass: businessCardEditTableViewCell.self)
        tableView.hx_registerCell(cellClass: businessCardIntroduceView.self)
        tableView.backgroundColor = UIColor(rgb: 0xF8F8F8)
        
        return tableView
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "名片编辑"
        view.backgroundColor = UIColor(rgb: 0xF8F8F8)
        view.addSubview(tableView)
        

        // Do any additional setup after loading the view.
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension businessCardEditViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0{
                return 70
            }else{
                return 50
            }
        }else if indexPath.section == 3{
            return 100.0
        }
        return 50.0;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as businessCardHeadCell
                cell.headImageView.image = UIImage.init(named: "")
                cell.headerClickBlock = {
                    
                    let alertController = UIAlertController(title: nil, message: nil,
                                                            preferredStyle: .actionSheet)
                    let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                    let deleteAction = UIAlertAction(title: "拍照", style: .default, handler: nil)
//                    let dd = UIAlertAction(title: "hahh", style: .default, handler: { (make) in
//                        HDPhotoImageManager.getCameraAuthorization({ [unowned self](bool) in
//                            guard bool, UIImagePickerController.isSourceTypeAvailable(.camera) else {
//                                return
//                            }
//
//                        })
//                    })
                    
                    let archiveAction = UIAlertAction(title: "从手机相册选择", style: .default, handler: nil)
                    alertController.addAction(cancelAction)
                    alertController.addAction(deleteAction)
                    alertController.addAction(archiveAction)
//                    alertController.addAction(dd)
                    self.present(alertController, animated: true, completion: nil)
//                    let view:HDAlertImagePickerView = HDAlertImagePickerView.loadFromXib()
//                    hdSharedAlertManager.addContentView(contentView: view)
//                    hdSharedAlertManager.show()
                }
                return cell
            }else{
                let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as businessCardEditTableViewCell
                if indexPath.row == 1 {
                    cell.leftTitleLabel.text = "姓名"
                    self.nameTextFeild = cell.contentTextFeild;
                }else{
                    cell.leftTitleLabel.text = "工号"
                }
                return cell
            }
            
        }else if indexPath.section == 1 {
            let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as businessCardEditTableViewCell
            if indexPath.row == 0 {
                cell.leftTitleLabel.text = "公司"
            }else{
                cell.leftTitleLabel.text = "职位"
                self.positionTextFeild = cell.contentTextFeild
            }
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as businessCardEditTableViewCell
            if indexPath.row == 0 {
                cell.leftTitleLabel.text = "手机"
                self.phoneTextFeild = cell.contentTextFeild
            }else if indexPath.row == 1{
                cell.leftTitleLabel.text = "微信号"
                self.wechatTextFeild = cell.contentTextFeild
            }else{
                cell.leftTitleLabel.text = "邮箱"
                self.emailTextFeild = cell.contentTextFeild
            }
            return cell
        }else if indexPath.section == 3 {
            let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as businessCardIntroduceView
            return cell
            
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
            headView.backgroundColor = UIColor(rgb: 0xF1F5FE)
            
            let headMarkL: UILabel = UILabel(frame: CGRect(x: 15, y: 0, width: view.bounds.width - 30, height: 50))
            headMarkL.backgroundColor = UIColor(rgb: 0xF1F5FE)
            headMarkL.text = "带*号为必填项，当填写完成后提交公司审核，审核通过后，新内容生效，名片信息更新。"
            headMarkL.textColor = UIColor(rgb: 0x497BEC)
            headMarkL.numberOfLines = 0
            headMarkL.font = UIFont.systemFont(ofSize: 13.0)
            headView.addSubview(headMarkL)
            return headView
        }
        
        let headView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 10))
        //        headView.backgroundColor = UIColor.lightGray
        return headView
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else if section == 1 {
            return 2
        }else if section == 2 {
            return 3
        }else if section == 3 {
            return 1
        }
        return 0
    }
    
    
}

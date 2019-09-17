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

class businessCardEditViewController: baseViewController, buttonClickDelegate {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height), style: .grouped)
        tableView.sectionFooterHeight = 0
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100;
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.hx_registerCell(cellClass: businessCardHeadCell.self)
        tableView.hx_registerCell(cellClass: businessCardEditTableViewCell.self)
        tableView.hx_registerCell(cellClass: editCardIntroduceCell.self)
        tableView.backgroundColor = UIColor(rgb: 0xF8F8F8)
        
        return tableView
    }()
    let disposeBag = DisposeBag()
    var intrudutionHeight: CGFloat = 120

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "名片编辑"
        view.backgroundColor = UIColor(rgb: 0xF8F8F8)
        view.addSubview(tableView)
        
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension businessCardEditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as businessCardHeadCell
                cell.headImageView.image = UIImage.init(named: "normalHeader")
                cell.headerClickBlock = {
                    
                    let acVC = ActionSheetViewController(cellTitleList: ["拍照", "从手机相册选择"])!
                    acVC.valueBlock = { index in
                        if index == 0 {
                            HDPhotoImageManager.getCameraAuthorization({ [unowned self](bool) in
                                guard bool, UIImagePickerController.isSourceTypeAvailable(.camera) else {
                                    return
                                }
                                UIImagePickerController.rx.createWithParent(self) { picker in
                                    picker.sourceType = .camera
                                    }.flatMap { $0.rx.didFinishPickingMediaWithInfo }
                                    .map{ $0[.originalImage] as! UIImage }
                                    .bind(to: cell.headImageView.rx.image)
                                    .disposed(by: self.disposeBag)
                                
                            })
                        }else if index == 1 {
                            HDPhotoImageManager.getPhotoLibraryAuthorization { [unowned self](bool) in
                                guard bool, UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                                    return
                                }
                                UIImagePickerController.rx.createWithParent(self) { picker in
                                    picker.sourceType = .photoLibrary
                                    picker.modalPresentationStyle = .overCurrentContext
                                    }
                                    .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                                    .map { $0[.originalImage] as! UIImage}
                                    .bind(to: cell.headImageView.rx.image)
                                    .disposed(by: self.disposeBag)
                                
                            }
                        }
                    }
                    self.present(acVC, animated: false, completion:  nil)
                }
                return cell
            }else{
                let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as businessCardEditTableViewCell
                if indexPath.row == 1 {
                    cell.leftTitleLabel.text = "姓名"
                    cell.contentTextFeild.placeholder = "此项必填"
                    self.nameTextFeild = cell.contentTextFeild;
                    
                }else{
                    cell.leftTitleLabel.text = "工号"
                    cell.contentTextFeild.placeholder = "此项必填"
                    cell.lineView.isHidden = true
                }
                return cell
            }
            
        }else if indexPath.section == 1 {
            let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as businessCardEditTableViewCell
            if indexPath.row == 0 {
                cell.leftTitleLabel.text = "公司"
                cell.contentTextFeild.placeholder = "此项必填"
            }else{
                cell.leftTitleLabel.text = "职位"
                self.positionTextFeild = cell.contentTextFeild
                cell.contentTextFeild.placeholder = "此项必填"
                cell.lineView.isHidden = true
            }
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as businessCardEditTableViewCell
            if indexPath.row == 0 {
                cell.leftTitleLabel.text = "手机"
                self.phoneTextFeild = cell.contentTextFeild
                cell.contentTextFeild.placeholder = "此项必填"
            }else if indexPath.row == 1{
                cell.leftTitleLabel.text = "微信号"
                self.wechatTextFeild = cell.contentTextFeild
                cell.contentTextFeild.placeholder = "未填写"
                cell.needLabel.isHidden = true
            }else{
                cell.leftTitleLabel.text = "邮箱"
                cell.contentTextFeild.placeholder = "未填写"
                cell.lineView.isHidden = true
                cell.needLabel.isHidden = true
                self.emailTextFeild = cell.contentTextFeild
            }
            return cell
        }else if indexPath.section == 3 {
            let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as editCardIntroduceCell
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return 85
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
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
//                headView.backgroundColor = background_Color
        return headView
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3 {
          let spaceView = UIView.init(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 85))
            spaceView.backgroundColor = UIColor(rgb: 0xF8F8F8)
           let submitBtn = UIButton.init(type: .roundedRect)
            spaceView.addSubview(submitBtn)
            submitBtn.frame = CGRect(x: 15, y: 20, width: view.bounds.width - 30, height: 45)
            submitBtn.backgroundColor = UIColor(rgb: 0x497BEC)
            submitBtn.setTitle("提交审核", for: .normal)
            submitBtn.setTitleColor(UIColor.white, for: .normal)
            submitBtn.layer.cornerRadius = 23.0
            return spaceView
        }else {
            let footView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 0))
            footView.backgroundColor = background_Color
            return footView
        }
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
        }else if section == 4 {
            return 1
        }
        return 0
    }
    
    func butonClickBy(_ sender: UIButton) {
        
    }
}

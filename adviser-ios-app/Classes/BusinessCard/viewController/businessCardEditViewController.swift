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
    
    var configuration:[[(title:String,
        placeholder:String,
        isNeed:Bool,
        isEnabled:Bool,
        keyboardType: UIKeyboardType)]]
        = [[("头像", "此项必填", true, true, .default),
            ("姓名", "此项必填", true, true, .default),
            ("工号", "此项必填", true, true, .default)],
           [("公司", "此项必填", true, false, .default),
            ("职位", "此项必填", true, true, .default)],
          [("手机", "此项必填", true, true, .namePhonePad),
           ("微信号", "此项必填", false, true, .default),
           ("邮箱", "此项必填", false, true, .emailAddress)],
          [("个人简介", "此项必填", true, true, .default)]]

    var contentArr    =  [["","",""],
                          ["恒大金融财富管理（深圳）有限公司",""],
                          ["","",""],
                          [""]]
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(contentTextFieldDidEndEditing(_:)), name: UITextField.textDidEndEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(contentTextFieldDidEndEditing(_:)), name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "名片编辑"
        view.backgroundColor = UIColor(rgb: 0xF8F8F8)
        view.addSubview(tableView)
        if let phoneNo = UserDefaults.standard.string(forKey: USERPHONEKEY) {
            businessCardEditManager.shared.getCardInfo(vc: self, phoneNo: phoneNo)
        }
    }
    func refrenUI(with model:businessCardItemModel) {
        let content = [[model.avatar,model.employeeName,model.employeeNo],
                       ["恒大金融财富管理（深圳）有限公司",model.jobNames],
                       [model.phoneNo,model.wechatAccount,model.email],
                       [model.profile]]
        for (section, arr) in content.enumerated() {
            for(row, contentStr) in arr.enumerated() {
                contentArr[section][row] = contentStr
            }
        }
    }
    @objc func contentTextFieldDidEndEditing(_ noti:NSNotification) {
        if let textFiled = noti.object as? BusinessCardTextField,
           let indexPath = textFiled.indexPath{
           contentArr[indexPath.section][indexPath.row] = textFiled.text ?? ""
        }
        if let textView = noti.object as? BusinessCardTextView,
           let indexPath = textView.indexPath{
            contentArr[indexPath.section][indexPath.row] = textView.text ?? ""
        }
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension businessCardEditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return configuration.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0,indexPath.row == 0  {
            let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as businessCardHeadCell
            cell.headImageView.image = UIImage.init(named: "normalHeader")
            cell.headerClickBlock = {[unowned self] () in
                let acVC = ActionSheetViewController(cellTitleList: ["拍照", "从手机相册选择"])!
                acVC.valueBlock = { [unowned self] index  in
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
        }else if indexPath.section == configuration.count - 1 {
            let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as editCardIntroduceCell
            cell.contentTextView.indexPath = indexPath
            cell.contentTextView.text = contentArr[indexPath.section][indexPath.row]
            return cell
        }
        let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as businessCardEditTableViewCell
        cell.leftTitleLabel.text = configuration[indexPath.section][indexPath.row].title
        cell.contentTextFeild.placeholder = configuration[indexPath.section][indexPath.row].placeholder
        cell.contentTextFeild.text = contentArr[indexPath.section][indexPath.row]
        cell.needLabel.isHidden = !configuration[indexPath.section][indexPath.row].isNeed
        cell.lineView.isHidden  = indexPath.row == configuration[indexPath.section].count - 1
        cell.contentTextFeild.indexPath = indexPath
        cell.contentTextFeild.keyboardType = configuration[indexPath.section][indexPath.row].keyboardType
        cell.contentTextFeild.isEnabled = configuration[indexPath.section][indexPath.row].isEnabled
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
            submitBtn.addTarget(self, action: #selector(submitBtnBtnClicked), for: .touchUpInside)
            submitBtn.layer.cornerRadius = 23.0
            return spaceView
        }else {
            let footView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 0))
            footView.backgroundColor = background_Color
            return footView
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configuration[section].count
    }
    
    @objc func submitBtnBtnClicked() {
        let paramter = ["avatar":contentArr[0][0],
                        "name":contentArr[0][1],
                        "employeeNumber":contentArr[0][2],
                        "jobNames":contentArr[1][1],
                        "phoneNo":contentArr[2][0],
                        "wechatAccount":contentArr[2][1],
                        "email":contentArr[2][2],
                        "profile":contentArr[3][0]]
        businessCardEditManager.shared.updateCardInfo(vc: self, paramter: paramter)
    }
}

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
import Kingfisher

class BusinessCardEditViewController: BaseViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height), style: .grouped)
        tableView.sectionFooterHeight = 0
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100;
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.hx_registerCell(cellClass: BusinessCardHeadCell.self)
        tableView.hx_registerCell(cellClass: BusinessCardEditTableViewCell.self)
        tableView.hx_registerCell(cellClass: EditCardIntroduceCell.self)
        tableView.backgroundColor = UIColor(rgb: 0xF8F8F8)
        
        return tableView
    }()
    let disposeBag = DisposeBag()
    var intrudutionHeight: CGFloat = 120
    
    var headerNormalImage: UIImage!
    
    var iscanEdit: Bool = true {
        didSet {
            updateConfige()
        }
    }
    
    var headerAttriStr: NSMutableAttributedString!
    
    
    var configuration:[[(title:String,
        placeholder:String,
        isNeed:Bool,
        isEnabled:Bool,
        keyboardType: UIKeyboardType)]]!

    var contentArr    =  [["","",UserDefaults.standard.string(forKey: USERICNO)],
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
        headerNormalImage = UIImage(named: "normalHeader")
       configuration = [[("头像", "此项必填", true, iscanEdit, .default),
          ("姓名", "此项必填", true, iscanEdit, .default),
          ("工号", "此项必填", true, false, .default)],
         [("公司", "此项必填", true, false, .default),
          ("职位", "此项必填", true, iscanEdit, .default)],
         [("手机", "此项必填", true, iscanEdit, .namePhonePad),
          ("微信号", "未填写", false, iscanEdit, .default),
          ("邮箱", "未填写", false, iscanEdit, .emailAddress)],
         [("个人简介", "可输入您的从业经验、所获荣誉、简单介绍等", true, iscanEdit, .default)]]
        headerAttriStr = attributedString(value: "带*号为必填项，当填写完成后提交公司审核，审核通过后，新内容生效，名片信息更新。", attriString: "*")
        if let employeeNumber = UserDefaults.standard.string(forKey: USERICNO) {
            let manager = BusinessCardEditManager()
            manager.getCardInfo(vc: self, employeeNumber: employeeNumber)
        }
    }
    
    func updateConfige() {
        configuration = [[("头像", "此项必填", true, iscanEdit, .default),
         ("姓名", "此项必填", true, iscanEdit, .default),
         ("工号", "此项必填", true, false, .default)],
        [("公司", "此项必填", true, false, .default),
         ("职位", "此项必填", true, iscanEdit, .default)],
        [("手机", "此项必填", true, iscanEdit, .namePhonePad),
         ("微信号", "未填写", false, iscanEdit, .default),
         ("邮箱", "未填写", false, iscanEdit, .emailAddress)],
        [("个人简介", "可输入您的从业经验、所获荣誉、简单介绍等", true, iscanEdit, .default)]]
    }
    
    func refrenUI(with model:BusinessCardModel) {
        if model.examineStatus == 0 {
            headerAttriStr = attributedString(value: "带*号为必填项，当填写完成后提交公司审核，审核通过后，新内容生效，名片信息更新。", attriString: "*")
            iscanEdit = true
        }else if model.examineStatus == 1 {
            headerAttriStr = attributedString(value: "您已于" + model.createTime + "提交审核，本页内容为待审核内容，请等待审核结果，审核通过后新内容生效。", attriString: model.createTime)
            iscanEdit = false
        }else if model.examineStatus == 2 {
            headerAttriStr = attributedString(value: "您已于" + model.createTime + "审核通过。", attriString: model.createTime)
            iscanEdit = true
        }else if model.examineStatus == 3 {
            headerAttriStr = attributedString(value: "您于" + model.createTime + "提交的审核未通过，主要原因为：" + model.refuseReason + "敬请修改后，再次提交审核。", attriString: model.refuseReason)
            iscanEdit = true
        }
        let content = [[model.data?.data!.avatar,model.data?.data!.employeeName,UserDefaults.standard.string(forKey: USERICNO)],
                       ["恒大金融财富管理（深圳）有限公司",model.data?.data!.jobNames],
                       [model.data?.data!.phoneNo,model.data?.data!.wechatAccount,model.data?.data!.email],
                       [model.data?.data!.profile]]
        for (section, arr) in content.enumerated() {
            for(row, contentStr) in arr.enumerated() {
                contentArr[section][row] = contentStr
            }
        }
        tableView.reloadData()
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
    
    func attributedString(value: String,attriString: String) -> NSMutableAttributedString {
        let attrStr = NSMutableAttributedString.init(string: value)
        if attriString.count > 0 {
            let range = value.range(of: attriString)
            let nsrange = NSRange(range!, in: value) // Range to NSRange
            attrStr.addAttribute(.foregroundColor, value: UIColor.red, range: nsrange)
        }
        return attrStr
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension BusinessCardEditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return configuration.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0,indexPath.row == 0  {
            let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as BusinessCardHeadCell
            if let avatar: String = contentArr[0][0],
                let headrurl = URL(string: imageBaseUrl + avatar){
                cell.headImageView.kf.setImage(with: ImageResource(downloadURL: headrurl), placeholder: headerNormalImage)
            }else {
                cell.headImageView.image = headerNormalImage
            }
            cell.headImageView.isUserInteractionEnabled = iscanEdit
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
                                picker.modalPresentationStyle = .overCurrentContext
                                }.flatMap { $0.rx.didFinishPickingMediaWithInfo }
                                .map{
                                    let  image  =  $0[.originalImage] as! UIImage
                                    let que = DispatchQueue.global(qos: .default)
                                    que.async {
                                         let defaultStand = UserDefaults.standard
                                        UploadImageManager().uploadBussinessCardHeader(vc: self, image: image, phoneNo: defaultStand.string(forKey: USERPHONEKEY)!)
                                    }
                                    self.headerNormalImage = image
                                    return image
                                }
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
                                .map {
                                    let  image  =  $0[.originalImage] as! UIImage
                                    let que = DispatchQueue.global(qos: .default)
                                    que.async {
                                        let defaultStand = UserDefaults.standard
                                        UploadImageManager().uploadBussinessCardHeader(vc: self, image: image, phoneNo: defaultStand.string(forKey: USERPHONEKEY)!)
                                    }
                                    self.headerNormalImage = image
                                    return image

                                }
                                .bind(to: cell.headImageView.rx.image)
                                .disposed(by: self.disposeBag)

                        }
                    }
                }
                self.present(acVC, animated: false, completion:  nil)
            }
            return cell
        }else if indexPath.section == configuration.count - 1 {
            let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as EditCardIntroduceCell
            cell.contentTextView.indexPath = indexPath
            cell.contentTextView.text = contentArr[indexPath.section][indexPath.row]
            cell.contentTextView.isEditable = iscanEdit
            cell.contentTextView.placehoderLabel?.isHidden = (cell.contentTextView.text.count > 0)
            cell.wordCountLabel.text = "\(cell.contentTextView.text.count)"
            return cell
        }
        let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as BusinessCardEditTableViewCell
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
            headMarkL.textColor = UIColor(rgb: 0x497BEC)
            headMarkL.numberOfLines = 0
            headMarkL.font = UIFont.systemFont(ofSize: 13.0)
            headMarkL.attributedText = headerAttriStr
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
           let submitBtn = HDCustomBution.init(type: .roundedRect)
            spaceView.addSubview(submitBtn)
            submitBtn.frame = CGRect(x: 15, y: 20, width: view.bounds.width - 30, height: 45)
            submitBtn.backgroundColor = UIColor(rgb: 0x497BEC)
            submitBtn.setTitle("提交审核", for: .normal)
            submitBtn.setTitleColor(UIColor.white, for: .normal)
            submitBtn.isEnabled = iscanEdit
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
        self.view.endEditing(true)
        if let errorTip = verifyCommit() {
            BusinessCardCommitAlertView(content: errorTip).show()
            return
        }
        let paramter = ["avatar":contentArr[0][0],
                        "name":contentArr[0][1],
                        "employeeNumber":contentArr[0][2],
                        "jobNames":contentArr[1][1],
                        "phoneNo":contentArr[2][0],
                        "wechatAccount":contentArr[2][1],
                        "email":contentArr[2][2],
                        "profile":contentArr[3][0]]
        BusinessCardEditManager().updateCardInfo(vc: self, paramter: paramter as [String : Any])
    }
}
extension BusinessCardEditViewController{
    func  verifyCommit()->String? {
        var tipArr:[String] = []
        if let avatar = contentArr[0][0], avatar.count == 0 {
            tipArr.append("头像")
        }
        if let name = contentArr[0][1], name.count == 0 {
            tipArr.append("姓名")
        }
        if let employeeNumber = contentArr[0][2], employeeNumber.count == 0 {
            tipArr.append("工号")
        }
        if let company = contentArr[1][0], company.count == 0 {
            tipArr.append("公司")
        }
        if let jobNames = contentArr[1][1], jobNames.count == 0 {
            tipArr.append("职位")
        }
        if let phoneNo = contentArr[2][0], phoneNo.count == 0 {
            tipArr.append("手机")
        }
        if tipArr.count == 0 {
            return nil
        }
        return tipArr.joined(separator: "、") + "为必填项，输入之后才可以保存。"
    }
}

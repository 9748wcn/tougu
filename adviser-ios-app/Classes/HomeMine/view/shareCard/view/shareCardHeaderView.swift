//
//  shareCardHeaderView.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/7.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import Kingfisher

class shareCardHeaderView: UIView {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var cardNoLabel: UILabel!
    
    @IBOutlet weak var workNameLabel: UILabel!
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var wechatLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var QRCodeLabel: UIImageView!
    
    override func awakeFromNib() {
        let codeView = QRCodeView(frame: CGRect(x: 0, y: 0, width: 64, height: 64), content: "测试", colors: [UIColor.yellow,UIColor.red])
        QRCodeLabel.addSubview(codeView)
    }
    
    func updateUI(dataModel: shareCardInfoModel) {
        self.headerImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: dataModel.avatar!)!), placeholder: UIImage(named: "normalHeader"))
        self.nameLabel.text = dataModel.employeeName
        self.cardNoLabel.text = dataModel.employeeNo
        self.workNameLabel.text = dataModel.jobNames
        self.phoneLabel.text = dataModel.phoneNo
        self.wechatLabel.text = dataModel.wechatAccount
        self.emailLabel.text = dataModel.email
        self.emailLabel.text = dataModel.email
    }
    
}

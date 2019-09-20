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
//        let codeView = QRCodeView(frame: CGRect(x: 0, y: 0, width: 64, height: 64), content: "测试", colors: [UIColor.yellow,UIColor.red])
//        QRCodeLabel.addSubview(codeView)
        headerImageView.layer.cornerRadius = 36.0
        headerImageView.clipsToBounds = true
    }
    
    func updateUI(dataModel: shareCardModel) {
        if dataModel.data?.data?.avatar != nil {
            let avatarUrl = imageBaseUrl + (dataModel.data?.data?.avatar!)!
            
            self.headerImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: avatarUrl)!), placeholder: UIImage(named: "normalHeader"))
        }
        if dataModel.data?.data?.employeeName != nil {
            self.nameLabel.text = dataModel.data?.data?.employeeName
        }
        if dataModel.data?.data?.employeeNo != nil {
            self.cardNoLabel.text = dataModel.data?.data?.employeeNo
        }
        if dataModel.data?.data?.jobNames != nil {
            self.workNameLabel.text = dataModel.data?.data?.jobNames
        }
        if dataModel.data?.data?.phoneNo != nil {
            self.phoneLabel.text = dataModel.data?.data?.phoneNo
        }
        if dataModel.data?.data?.wechatAccount != nil {
            self.wechatLabel.text = dataModel.data?.data?.wechatAccount
        }
        if dataModel.data?.data?.email != nil {
            self.emailLabel.text = dataModel.data?.data?.email
        }
        if dataModel.data?.resultImage != nil {
            let base64String = dataModel.data?.resultImage!.replacingOccurrences(of: "data:image/png;base64,", with: "")
            //转换尝试判断，有可能返回的数据丢失"=="，如果丢失，swift校验不通过
            var imageData = Data(base64Encoded: base64String!, options: .ignoreUnknownCharacters)
            if imageData == nil {
                imageData = Data(base64Encoded: base64String! + "==", options: .ignoreUnknownCharacters) //如果数据不正确，添加"=="重试
            }
            var image:UIImage?
            if imageData != nil {
                image = UIImage(data: imageData!) //转换内容
            }
            if image != nil {
                QRCodeLabel.image = image
            }
        }
        
        
    }
    
}

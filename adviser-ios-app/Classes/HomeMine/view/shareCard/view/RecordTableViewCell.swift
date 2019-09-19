//
//  RecordTableViewCell.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/9.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class RecordTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel!
    var headerImage: UIImageView!
    var timeLabel: UILabel!
    var recordList: UserBehaviourItemModel? {
        didSet {
            if recordList != nil {
                setupUI()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    func setupUI() {
        for item: UIView in self.contentView.subviews {
            item.removeFromSuperview()
        }
        let bgView: UIView = UIView.init()
        self.contentView.addSubview(bgView)
        bgView.backgroundColor = UIColor(rgb: 0xFAFAFB)
//        bgView.backgroundColor = UIColor.red
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
            make.top.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-5)
        }
        headerImage = UIImageView.init()
        bgView.addSubview(headerImage)
        headerImage.snp.makeConstraints { (make) in
            make.left.equalTo(bgView.snp.left).offset(15)
            make.top.equalTo(bgView.snp.top).offset(12)
            make.width.height.equalTo(36)
        }
        if recordList?.avatar != nil {
            let avatarUrl = "https://iqfdfs.hdfax.com/" + (recordList?.avatar!)!
            headerImage.kf.setImage(with: ImageResource(downloadURL: URL(string: avatarUrl)!), placeholder: UIImage(named: "userHeader"))
        }else {
            headerImage.image = UIImage(named: "userHeader")
        }
        nameLabel = UILabel.init()
        bgView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerImage.snp.right).offset(15)
            make.top.equalTo(bgView.snp.top).offset(12)
            make.height.equalTo(14)
        }
        nameLabel.font = textFont14
        nameLabel.textColor = text_Color
        nameLabel.text = (recordList?.userName != nil) ? recordList?.userName! : ""
//
        timeLabel = UILabel.init()
        bgView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.height.equalTo(17)
        }
        timeLabel.textColor = Notext_Color
        timeLabel.font = textFont12
        if recordList?.createTime != nil {
            timeLabel.text = recordList?.createTime!
        }
        
        var behaviours: Array<String> = []
        if (recordList?.viewBusinessCard != nil) && (recordList!.viewBusinessCard! == 1) {
            behaviours.append("查看了您的名片")
        }
        if(recordList?.callUp != nil) && (recordList!.callUp! == 1) {
            behaviours.append("拨打了电话号码")
        }
        if (recordList?.copyWechatAccount != nil) && (recordList!.copyWechatAccount! == 1) {
            behaviours.append("复制了微信号")
        }
        if (recordList?.copyEmail != nil) && (recordList!.copyEmail! == 1) {
            behaviours.append("复制了邮箱")
        }
        if (recordList?.enterRegister != nil) && (recordList!.enterRegister! == 1) {
            behaviours.append("进入注册及认证流程")
        }
        if (recordList?.bindSuccess != nil) && (recordList!.bindSuccess! == 1) {
            behaviours.append("完成绑定，已成为您的客户")
        }
//
        for (index,value) in behaviours.enumerated() {
            let circleImageView: UIImageView = UIImageView.init(image: UIImage(named: "recordCircle"))
            bgView.addSubview(circleImageView)
            circleImageView.snp.makeConstraints { (make) in
                make.left.equalTo(timeLabel.snp.left)
                make.width.height.equalTo(5)
                make.top.equalTo(timeLabel.snp.bottom).offset(index*20 + 20)
            }

            let line: UIView = UIView.init()
            line.backgroundColor = UIColor(rgb: 0xE7E8EB)
            bgView.addSubview(line)
            line.snp.makeConstraints { (make) in
                make.centerX.equalTo(circleImageView.snp.centerX)
                make.bottom.equalTo(circleImageView.snp.top)
                make.width.equalTo(1)
                make.height.equalTo(20)
            }
            if index == 0 {
                line.isHidden = true
            }

            let recordLabel: UILabel = UILabel.init()
            bgView.addSubview(recordLabel)
            recordLabel.textColor = Notext_Color
            recordLabel.font = textFont12
            recordLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(circleImageView.snp.centerY)
                make.left.equalTo(circleImageView.snp.right).offset(5)
            }
            recordLabel.text = value
            
            if (index == behaviours.endIndex - 1) {
                contentView.snp_makeConstraints { (make) -> Void in
                make.bottom.equalTo(recordLabel.snp_bottom).offset(12)
                    make.leading.equalTo(self)
                    make.top.equalTo(self)
                    make.trailing.equalTo(self)
                    
                }
            }
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

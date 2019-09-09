//
//  RecordTableViewCell.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/9.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import SnapKit

class RecordTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel!
    var headerImage: UIImageView!
    var timeLabel: UILabel!
    var recordListArray: Array<String> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    func setupUI() {
        let bgView: UIView = UIView.init()
        self.contentView.addSubview(bgView)
        bgView.backgroundColor = UIColor(rgb: 0xFAFAFB)
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
        
        nameLabel = UILabel.init()
        bgView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerImage.snp.right).offset(15)
            make.top.equalTo(bgView.snp.top).offset(12)
            make.height.equalTo(14)
        }
        nameLabel.font = textFont14
        nameLabel.textColor = text_Color
        
        timeLabel = UILabel.init()
        bgView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.height.equalTo(17)
        }
        timeLabel.textColor = Notext_Color
        timeLabel.font = textFont12
        
        for (index,value) in recordListArray.enumerated() {
            let circleImageView: UIImageView = UIImageView.init(image: UIImage(named: "recordCircle"))
            bgView.addSubview(circleImageView)
            circleImageView.snp.makeConstraints { (make) in
                make.left.equalTo(timeLabel.snp.left)
                make.width.height.equalTo(5)
                make.top.equalTo(timeLabel.snp.bottom).offset(index*20 + 15)
            }
            
            let line: UIView = UIView.init()
            line.backgroundColor = UIColor(rgb: 0xE7E8EB)
            bgView.addSubview(line)
            line.snp.makeConstraints { (make) in
                make.centerX.equalTo(circleImageView.snp.centerX)
                make.bottom.equalTo(circleImageView.snp.top)
                make.width.equalTo(1)
                make.height.equalTo(15)
            }
            if index == 0 {
                line.isHidden = true
            }
            
            let recordLabel: UILabel = UILabel.init()
            bgView.addSubview(recordLabel)
            recordLabel.textColor = Notext_Color
            recordLabel.font = textFont12
            recordLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(circleImageView.centerY)
                make.left.equalTo(circleImageView.snp.right).offset(5)
            }
            recordLabel.text = value
            
            
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

extension RecordTableViewCell {
    convenience init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, recordList: Array<String>) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        recordListArray = recordList
        setupUI()
    }
}

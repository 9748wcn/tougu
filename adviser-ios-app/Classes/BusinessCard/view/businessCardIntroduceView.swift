//
//  businessCardIntroduceView.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/2.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import SnapKit

class businessCardIntroduceView: UITableViewCell, UITextViewDelegate {
    
    var contentTextView: ASAutoHeightTextView!
    var contentLenth: NSInteger!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let markLabel: UILabel = UILabel(frame: CGRect(x: 15, y: 15, width: 100, height: 20))
        markLabel.textColor = UIColor(rgb: 0x8F94A7)
        markLabel.text = "个人简介"
        self.contentView.addSubview(markLabel)
        
        let wordCountLabel: UILabel = UILabel.init()
        self.contentView.addSubview(wordCountLabel)
        wordCountLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            make.centerY.equalTo(markLabel.snp.centerY)
        }
        wordCountLabel.textColor = UIColor(rgb: 0xC4C7D1)
        wordCountLabel.text = "/200"
        
        let wordNumLabel: UILabel = UILabel.init()
        self.contentView.addSubview(wordNumLabel)
        wordNumLabel.snp.makeConstraints { (make) in
            make.right.equalTo(wordCountLabel.snp.left)
            make.centerY.equalTo(wordCountLabel.snp.centerY)
        }
        wordNumLabel.text = "0"
        wordNumLabel.textColor = UIColor(rgb: 0x27314A)
        
        contentTextView = ASAutoHeightTextView.init()
        self.contentView.addSubview(contentTextView)
        contentTextView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.height.equalTo(50)
            make.top.equalTo(markLabel.snp.bottom).offset(15)
        }
        contentTextView.font = UIFont.systemFont(ofSize: 14.0)
        contentTextView.delegate = self
        contentTextView.textColor = UIColor(rgb: 0x27314A)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func textViewDidChange(_ textView: UITextView) {
        let frame: CGRect = textView.frame
        let constrainSize: CGSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        // 获取textview的真实高度
        let size = textView.sizeThatFits(constrainSize)
        if size.height > 50.0 {
            self.frame.size.height = 50.0 + (size.height)
        }
        textView.frame.size.height = size.height
    }
    
   
}

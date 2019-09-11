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
    
    typealias contentHeightBlock = (CGFloat) ->()
    var contentTextView: ASAutoHeightTextView!
    var contentLenth: NSInteger!
    var changeHeightBlock: contentHeightBlock!
    var contentHeight: CGFloat = 50.0
//    var spaceView: UIView!
//    var submitBtn: UIButton!
    var wordNumLabel: UILabel!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.backgroundColor = UIColor(rgb: 0xF8F8F8)
        self.selectionStyle = .none
//        let markLabel: UILabel = UILabel(frame: CGRect(x: 15, y: 15, width: 100, height: 20))
//        markLabel.textColor = UIColor(rgb: 0x8F94A7)
//        markLabel.text = "个人简介"
//        self.contentView.addSubview(markLabel)
//        
//        let wordCountLabel: UILabel = UILabel.init()
//        self.contentView.addSubview(wordCountLabel)
//        wordCountLabel.snp.makeConstraints { (make) in
//            make.right.equalTo(self.contentView.snp.right).offset(-20)
//            make.centerY.equalTo(markLabel.snp.centerY)
//        }
//        wordCountLabel.textColor = UIColor(rgb: 0xC4C7D1)
//        wordCountLabel.text = "/200"
//        
//        wordNumLabel = UILabel.init()
//        self.contentView.addSubview(wordNumLabel)
//        wordNumLabel.snp.makeConstraints { (make) in
//            make.right.equalTo(wordCountLabel.snp.left)
//            make.centerY.equalTo(wordCountLabel.snp.centerY)
//        }
//        wordNumLabel.text = "0"
//        wordNumLabel.textColor = UIColor(rgb: 0x27314A)
        
        contentTextView = ASAutoHeightTextView.init()
        self.contentView.addSubview(contentTextView)
        contentTextView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.height.greaterThanOrEqualTo(contentHeight)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
            make.top.equalTo(self.contentView.snp.top).offset(15)
        }
        contentTextView.font = UIFont.systemFont(ofSize: 14.0)
        contentTextView.delegate = self
        contentTextView.textColor = UIColor(rgb: 0x27314A)
        contentTextView.isScrollEnabled = false
//        contentTextView.backgroundColor = UIColor.c
//        self.backgroundColor = UIColor.black
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func textViewDidChange(_ textView: UITextView) {
//        wordNumLabel.text = "\(textView.text.count)"
        var textBounds: CGRect = textView.bounds
        let constrainSize: CGSize = CGSize(width: textBounds.size.width, height: CGFloat(MAXFLOAT))
        // 获取textview的真实高度
        let newsize = textView.sizeThatFits(constrainSize)
        textBounds.size = newsize
        textView.bounds = textBounds
        changeHeightBlock(newsize.height + 135)
//        if size.height > contentHeight {
//            contentHeight = size.height
//            self.frame.size.height = contentHeight + 135
//            contentTextView.snp.remakeConstraints { (make) in
//                make.left.equalTo(self.contentView.snp.left).offset(15)
//                make.right.equalTo(self.contentView.snp.right).offset(-15)
//                make.height.equalTo(contentHeight)
//                make.top.equalTo(self.contentView.snp.top).offset(50)
//            }
//            if changeHeightBlock != nil {
//                changeHeightBlock(contentHeight + 135)
//            }
//
//        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text.count > 200 {
            return false
        }else{
            return true
        }
    }
    
   
}

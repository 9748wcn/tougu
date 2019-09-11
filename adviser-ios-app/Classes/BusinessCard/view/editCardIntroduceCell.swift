//
//  editCardIntroduceCell.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/11.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class editCardIntroduceCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var wordCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentTextView.delegate = self
        contentTextView.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textViewDidChange(_ textView: UITextView) {
        wordCountLabel.text = "\(textView.text.count)"
        var textBounds: CGRect = textView.bounds
        let constrainSize: CGSize = CGSize(width: textBounds.size.width, height: CGFloat(MAXFLOAT))
        // 获取textview的真实高度
        let newsize = textView.sizeThatFits(constrainSize)
        textBounds.size = newsize
        textView.bounds = textBounds
        let tableView = getTableView()
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    func getTableView() -> UITableView {
        var tableView = self.superview
        while (!((tableView?.isKind(of: UITableView.self))!) && (tableView != nil)) {
            tableView = tableView?.superview
        }
        return tableView as! UITableView
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text.count > 200 {
            return false
        }else{
            return true
        }
    }
    
}

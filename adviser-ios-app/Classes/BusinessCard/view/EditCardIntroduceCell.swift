//
//  editCardIntroduceCell.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/11.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
class BusinessCardTextView: IDTextView{
    var indexPath:IndexPath?
}
class EditCardIntroduceCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var contentTextView: BusinessCardTextView!
    @IBOutlet weak var wordCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentTextView.delegate = self
        contentTextView.isScrollEnabled = false
        self.selectionStyle = .none
        contentTextView.id_maxLength = 200
        contentTextView.id_allowEmoji = false
        contentTextView.textChangeClouse = { [unowned self] (height: CGFloat, lenght: Int) -> Void in
            self.wordCountLabel.text = "\(lenght)"
            let tableView = self.getTableView()
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        contentTextView.id_supportAutoHeight = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func textViewDidChange(_ textView: UITextView) {
//        wordCountLabel.text = "\(textView.text.count)"
//        var textBounds: CGRect = textView.bounds
//        let constrainSize: CGSize = CGSize(width: textBounds.size.width, height: CGFloat(MAXFLOAT))
//        // 获取textview的真实高度
//        let newsize = textView.sizeThatFits(constrainSize)
//        textBounds.size = newsize
//        textView.bounds = textBounds
//        let tableView = getTableView()
//        tableView.beginUpdates()
//        tableView.endUpdates()
        
//    }
    
    func getTableView() -> UITableView {
        var tableView = self.superview
        while (!((tableView?.isKind(of: UITableView.self))!) && (tableView != nil)) {
            tableView = tableView?.superview
        }
        return tableView as! UITableView
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        wordCountLabel.text = "\(textView.text.count)"
        return true
    }
    
//    @available(iOS 2.0, *)
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "" {
//            return true
//        }
//        if textView.text.count >= 200 {
//            return false
//        }
//        return true
//    }
    
}

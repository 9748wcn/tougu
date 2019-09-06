//
//  businessSubmitBtnCell.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/5.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

protocol buttonClickDelegate: NSObjectProtocol {
    
    func butonClickBy(_ sender: UIButton)
}

class businessSubmitBtnCell: UITableViewCell {

    @IBOutlet weak var submitBtn: UIButton!
    weak var delegate: buttonClickDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        submitBtn.backgroundColor = UIColor(rgb: 0x497BEC)
        submitBtn.setTitle("提交审核", for: .normal)
        submitBtn.setTitleColor(UIColor.white, for: .normal)
        submitBtn.layer.cornerRadius = 23.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func sumbitClick(_ sender: Any) {
        delegate?.butonClickBy(sender as! UIButton)
    }
}

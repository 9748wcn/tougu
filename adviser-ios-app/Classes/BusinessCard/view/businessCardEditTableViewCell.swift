//
//  businessCardEditTableViewCell.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/8/31.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class businessCardEditTableViewCell: UITableViewCell {

    @IBOutlet weak var leftTitleLabel: UILabel!
    
    @IBOutlet weak var contentTextFeild: UITextField!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var needLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

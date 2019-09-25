//
//  businessCardEditTableViewCell.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/8/31.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class BusinessCardTextField: UITextField{
    var indexPath:IndexPath?
}

class BusinessCardEditTableViewCell: UITableViewCell {

    @IBOutlet weak var leftTitleLabel: UILabel!
    
    @IBOutlet weak var contentTextFeild: BusinessCardTextField!
    
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

//
//  personInfoTableViewCell.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/6.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class PersonInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeValueLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        typeValueLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(156)
            make.centerY.equalTo(typeLabel.snp.centerY)
        }
        typeValueLabel.textColor = text_Color
        typeValueLabel.font = UIFont.systemFont(ofSize: 15.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

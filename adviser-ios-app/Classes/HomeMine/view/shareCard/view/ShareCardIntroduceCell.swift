//
//  ShareCardIntroduceCell.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/9.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import SnapKit

class ShareCardIntroduceCell: UITableViewCell {
    
    @IBOutlet weak var introduceContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        introduceContentLabel.numberOfLines = 0
//        contentView.snp_makeConstraints { (make) -> Void in
//            make.bottom.equalTo(self.introduceContentLabel.snp_bottom).offset(10)
//            make.leading.equalTo(self)
//            make.top.equalTo(self)
//            make.trailing.equalTo(self)
//        }
//        contentView.snp.makeConstraints { (make) in
//            make.bottom.equalTo(self.introduceContentLabel.snp_bottom).offset(10)
//            make.leading.equalTo(self)
//            make.top.equalTo(self)
//            make.trailing.equalTo(self)
//        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

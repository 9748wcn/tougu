//
//  businessCardHeadCell.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/8/31.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class businessCardHeadCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    
    var headerClickBlock:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        headImageView.layer.cornerRadius = 25.0
        headImageView.clipsToBounds = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(gotoChangeHead))
        headImageView.addGestureRecognizer(tap)
        headImageView.isUserInteractionEnabled = true
        headImageView.contentMode = .scaleAspectFill
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func gotoChangeHead() {
        if self.headerClickBlock != nil {
            self.headerClickBlock!()
        }
    }
    
}

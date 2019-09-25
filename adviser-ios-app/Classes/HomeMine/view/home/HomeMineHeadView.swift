//
//  HomeMineHeadView.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/6.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit
import Kingfisher

class HomeMineHeadView: UIView {
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var headerView: UIImageView!
    @IBOutlet weak var iCNumberLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    weak var delegate:buttonClickDelegate?
    
    override func awakeFromNib() {
        let defaultStand = UserDefaults.standard
        if (defaultStand.string(forKey: USERNAMEKEY) != nil) {
            nameLabel.text = defaultStand.string(forKey: USERNAMEKEY)!
        }
        if (defaultStand.string(forKey: USERICNO) != nil) {
            iCNumberLabel.text = defaultStand.string(forKey: USERICNO)!
        }
        if (defaultStand.string(forKey: USERJOBKEY) != nil) {
            jobLabel.text = defaultStand.string(forKey: USERJOBKEY)!
        }
        headerView.layer.cornerRadius = 36.0
        headerView.clipsToBounds = true
    }
    
    @IBAction func seePersionInfo(_ sender: Any) {
        delegate?.butonClickBy(sender as! UIButton)
    }
    @IBAction func editCardClick(_ sender: Any) {
        delegate?.butonClickBy(sender as! UIButton)
    }
    @IBAction func shareCardClick(_ sender: Any) {
        delegate?.butonClickBy(sender as! UIButton)
    }
    
    func updateUI(model: PersonInfoModel) {
        nameLabel.text = (model.data?.employeeName != nil) ? model.data!.employeeName! : ""
        iCNumberLabel.text = (model.data?.employeeNumber != nil) ? model.data!.employeeNumber! : ""
        jobLabel.text = (model.data?.jobName != nil) ? model.data!.jobName! : ""
        teamLabel.text = (model.data?.groupName != nil) ? model.data!.groupName! : ""
        if model.data?.avatar != nil {
            let avatarUrl = imageBaseUrl + (model.data?.avatar!)!
            headerView.kf.setImage(with: ImageResource(downloadURL: URL(string: avatarUrl)!), placeholder: UIImage(named: "normalHeader"))
        }
    }
}

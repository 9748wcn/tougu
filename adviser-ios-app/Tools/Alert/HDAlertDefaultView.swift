//
//  HDAlert.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/3.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit

class HDAlertDefaultView: HDAlertBaseView {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var bottomContainerView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.stackView.removeArrangedSubview(secondBtn)
        secondBtn.removeFromSuperview()
        self.addRoundRect(radius: 8)
    }
    
    func setBtnTitles(titles:[String]) {
        if titles.count <= 0 {
            return
        }
        self.firstBtn.setTitle(titles[0], for: UIControl.State.normal)
        if titles.count >= 2 {
           self.secondBtn.setTitle(titles[0], for: UIControl.State.normal)
        }
    }
    
    func setTitle(title:String) {
        self.titleLabel.text = title
    }
    
    
    @IBAction func firstBtnPress(_ sender: Any) {
        hdSharedAlertManager.dismiss()
//        if self.delegate != nil {
            self.delegate?.alertClick?(index: 0)
//        }
    }
    
    @IBAction func secondBtnPress(_ sender: Any) {
        hdSharedAlertManager.dismiss()
//        if self.delegate != nil {
            self.delegate?.alertClick?(index: 1)
//        }
    }
    
    deinit {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

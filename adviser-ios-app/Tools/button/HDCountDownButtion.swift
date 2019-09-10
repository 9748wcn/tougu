//
//  HDCountDownButtion.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/8.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit

class HDCountDownButtion: UIButton {

    var countdownTimer: Timer?
    
    var remainingSeconds: Int = 0 {
        willSet {
            self.setTitle("\(newValue)S后重新获取", for: .normal)
            self.backgroundColor = noClick_buttonColor
            self.setTitleColor(UIColor.white, for: .normal)
            self.layer.borderWidth = 0.0
            
            if newValue <= 0 {
                self.setTitle("获取验证码", for: .normal)
                self.setTitleColor(main_buttonColor, for: .normal)
                self.backgroundColor = UIColor.white
                self.layer.borderColor = main_buttonColor.cgColor
                self.layer.borderWidth = 1.0
                isCounting = false
            }
        }
    }
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(_:)), userInfo: nil, repeats: true)
                remainingSeconds = 40
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
            }
            
            self.isEnabled = !newValue
        }
    }
    
    @objc func updateTime(_ timer: Timer) {
        remainingSeconds -= 1
    }
}

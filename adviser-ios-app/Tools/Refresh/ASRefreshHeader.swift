//
//  ASRefreshHeader.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/11.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class ASRefreshHeader: MJRefreshStateHeader {
    
    var loadingImage:UIImageView!
    
    override func prepare() {
        super.prepare()
        self.mj_h = 50
        self.stateLabel.isHidden = true
        self.lastUpdatedTimeLabel.isHidden = true
        loadingImage = UIImageView.init(image: UIImage(named: "mediumRefresh"))
        
        self.addSubview(loadingImage)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        loadingImage.center = CGPoint(x: self.centerX, y: self.centerY + 50)
    }
    
    override var state: MJRefreshState{
        didSet {
            switch state {
            case .idle:
                break
            case .pulling:
                break
            case .refreshing:
                anmationLoadingView()
                break
            default:
                break
            }
        }
    }
    
    //监听scrollView的contentOffset改变
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    //监听scrollView的contentSize改变
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    //监听scrollView的拖拽状态改变
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }
    
    func anmationLoadingView() {
        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = NSNumber.init(value: 0)
        rotationAnimation.toValue = NSNumber.init(value: M_PI * 2.0 * 3)
        rotationAnimation.duration = 1;
        rotationAnimation.isCumulative = false;
        rotationAnimation.repeatCount = MAXFLOAT;
        loadingImage.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }

}

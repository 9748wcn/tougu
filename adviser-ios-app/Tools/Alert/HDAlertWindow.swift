//
//  HDAlertWindow.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/10.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit

class HDAlertWindow: UIWindow, CAAnimationDelegate {
    
    var contentContainerView: UIView?
    var lastTranform3D:CATransform3D?
    
    lazy var blurMaskView: HDAlertBgView = {
        let maskView = HDAlertBgView.init(frame: self.bounds)
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.3
        return maskView
    }()
    
    lazy var dialogView: HDAlertBgView = {
        let dialogView = HDAlertBgView.init(frame: self.bounds)
        dialogView.backgroundColor = UIColor.clear
        return dialogView
    }()
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func customInit() {
        self.bounds = CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)
        self.backgroundColor = UIColor.clear;
        self.windowLevel = UIWindow.Level.statusBar+1
        NotificationCenter.default.addObserver(self, selector:#selector(orientationChanged(_:)), name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
        
    }
    
    @objc func orientationChanged(_ notification:Notification) {
        //获得当前运行中的设备
        let application:UIApplication = UIApplication.shared
        let orientation = application.statusBarOrientation;
        changeContentContainerViewByOrientation(orientation: orientation)
    }
    
    
    func changeContentContainerViewByOrientation(orientation:UIInterfaceOrientation) {
        if orientation.isLandscape {
            if lastTranform3D != nil {
              dialogView.transform = CATransform3DGetAffineTransform(lastTranform3D!).rotated(by:CGFloat.pi)
            }else {
                dialogView.transform =  CGAffineTransform.init(rotationAngle: CGFloat.pi)
            }
            lastTranform3D = dialogView.layer.transform
            
        }
        
        
    }
    
    
    func setupLevel(level:CGFloat) {
        self.windowLevel = UIWindow.Level(rawValue: level)
    }
    
    func showWithAnimation() {
        self.isUserInteractionEnabled = true;
        self.addSubview(dialogView)
        dialogView.addSubview(blurMaskView)
        blurMaskView.frame = dialogView.bounds
        guard let view:UIView = self.contentContainerView else {
            return
        }
        self.dialogView.addSubview(view)
        self.contentContainerView?.center = self.dialogView.center;
        self.isHidden = false;
        self.alpha = 1;
        startAnimation()
    }
    
    
    // 跳动一下的效果
    private func startAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform")
        let scale1 = CATransform3DMakeScale(0.9, 0.9, 1)
        let scale2 = CATransform3DMakeScale(1.1, 1.1, 1)
        let scale3 = CATransform3DMakeScale(1, 1, 1)
        animation.values = [scale1,scale2,scale3]
        animation.keyTimes = [0.05,0.5,0.95]
        animation.duration = 1.5
        animation.repeatCount = 1
        self.contentContainerView?.layer.add(animation, forKey: "imageViewEffect")
    }
    
    func dismissWithAnimation(completion:@escaping ()->Void){
    //重复点击发生时，防御后续点击
        self.isUserInteractionEnabled = false;
        UIView.animate(withDuration: 0.3, animations: {
          self.alpha = 0
        }) { (finished) in
            self.blurMaskView.removeFromSuperview()
            self.dialogView.removeFromSuperview()
            self.contentContainerView?.removeFromSuperview()
            self.contentContainerView = nil
//            self.isHidden = true
            self.removeFromSuperview()
            completion()
        }
}
    
   
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

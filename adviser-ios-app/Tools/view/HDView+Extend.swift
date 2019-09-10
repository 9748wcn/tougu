//
//  HDViewNib.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/15.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit

public enum HDShadowDirection {
    case left
    case right
    case top
    case bottom
    case all
}

public extension UIView
    
{
    static func loadFromXib<T>(withOwner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil) -> T where T: UIView
    {
        let bundle = Bundle.main
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        guard let view = nib.instantiate(withOwner: withOwner, options: options).first as? T else {
            fatalError("Could not load view from nib file.")
        }
        return view
    }
    
    
    func addShadow(_ direction:HDShadowDirection, radius:CGFloat) {
        
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = radius;
        self.layer.shadowColor = UIColor.black.cgColor
        let shadowWidth:CGFloat = radius/2
        var rect:CGRect
        
        switch direction {
        case .top:
          rect = CGRect(x: 0, y: shadowWidth, width: self.bounds.size.width, height: radius)
            break
        case .left:
            rect = CGRect(x: 0 - shadowWidth , y: 0 , width: radius, height: self.bounds.size.height)
            break
        case .right:
            rect = CGRect(x: self.bounds.size.width + shadowWidth, y: 0, width: radius, height: self.bounds.size.height)
            break
        case .bottom:
            rect = CGRect(x: 0, y: self.bounds.size.height + shadowWidth, width: self.bounds.size.width, height: radius)
            break
        default:
            self.layer.shadowOffset = CGSize.init(width: 0, height: 0)
            return
        }
       
        let path:UIBezierPath = UIBezierPath.init(rect: rect)
        self.layer.shadowPath = path.cgPath
    }
    
    
    func addRoundRect(radius:CGFloat) {
        let cornerRadius:CGFloat = radius
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.mask = maskLayer
    }
    
    func toCircle() {
        let cornerRadius:CGFloat = bounds.size.width/2
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.mask = maskLayer
    }
    //Shadow
    func setShadow() {
        self.layer.shadowColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 0.8).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 6
    }

    func addCornerRadius(borderWidth:CGFloat,cornerRadius:CGFloat,rgb:Int) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor.init(rgb: rgb).cgColor
        self.layer.cornerRadius = cornerRadius
    }
}
extension UIView {
    /// 宽
    public var W: CGFloat {
        return self.bounds.size.width
    }
    /// 高
    public var H: CGFloat {
        return self.bounds.size.height
    }
    /// X
    public var X: CGFloat {
        return self.frame.origin.x
    }
    /// Y
    public var Y: CGFloat {
        return self.frame.origin.y
    }
    /// bottom
    public var bottom:CGFloat{
        return Y+H
    }
    /// centerX
    public var centerX: CGFloat {
        return self.center.x
    }
    /// centerY
    public var centerY: CGFloat {
        return self.center.y
    }
}

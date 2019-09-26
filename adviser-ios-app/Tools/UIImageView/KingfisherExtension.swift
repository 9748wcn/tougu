//
//  KingfisherExtension.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/26.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import Foundation

extension UIImageView {
    
    func setImage(_ URLString: String?, _ placeHolderName: String?) {
        
        guard let URLString = URLString else { return }
        
        guard let placeHolderName = placeHolderName else { return }
        
        guard let url = URL(string: URLString) else { return }
        
        kf.setImage(with: url, placeholder: UIImage(named: placeHolderName))
    }
}

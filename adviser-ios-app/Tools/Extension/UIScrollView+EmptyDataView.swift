//
//  UIScrollView+EmptyDataView.swift
//  mgr-combat-map-ios
//
//  Created by HDCF003 on 2019/7/29.
//  Copyright © 2019 evergrande_caifu_manager. All rights reserved.
//
import EmptyDataSet_Swift
import Foundation
extension UIScrollView {
    
    func setupEmptyDataView() {
        self.emptyDataSetView {(view) in
            let titleL = "暂无数据";
            let attributesL:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor:kRGB(67, 67, 67)]
            view.titleLabelString(NSAttributedString(string: titleL, attributes: attributesL))
                .isScrollAllowed(true)
            //view.backgroundColor = kRGB(218, 218, 218)
        }
    }
}

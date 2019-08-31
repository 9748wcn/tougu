//
//  UIView+HDEmptyView.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/26.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit

private let emptyViewTag: Int = 350132706

extension UITableViewDataSource {
    func configEmptyView() -> UIView? {
        return HDLoadingEmptyView.loadFromXib()
    }
    
}

var firstTimeComeInvKey = "firstTimeComeInvKey"
//extension UITableView:HDRuntimeProtocol
//    
//{
//    var firstTimeComeIn: Bool {
//        set {
//            objc_setAssociatedObject(self, &firstTimeComeInvKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
//        }
//        
//        get {
//            if let rs = objc_getAssociatedObject(self, &firstTimeComeInvKey) as? Bool {
//                return rs
//            }
//            
//            return true
//        }
//    }
//    public static func hd_load() {
//        DispatchQueue.once(#function) {
//            BQTool.exchangeMethod(cls: self.classForCoder(), targetSel: #selector(self.reloadData), newSel: #selector(self.__reloadData))
//        }
//    }
//    
//   @objc func __reloadData() {
//        self.__reloadData()
//        checkEmpty()
//    }
//    
//    /// 检测tableView dataSource是否为空
//    private func checkEmpty() {
//        guard dataSource != nil else {
//            return
//        }
//        
//        if firstTimeComeIn {
//            firstTimeComeIn = false
//            return
//        }
//        let ds = dataSource!
//        // 获取tableView组数
//        var sections = 1
//        if ds.responds(to: #selector(ds.numberOfSections)) {
//            sections = ds.numberOfSections!(in: self)
//        }
//        // 判断是否有行数
//        var isEmpty = true
//        [sections].forEach {
//            if ds.tableView(self, numberOfRowsInSection: $0) != 0 {
//                isEmpty = false
//            }
//        }
//        
//        if isEmpty {
//            
//            if self.viewWithTag(emptyViewTag) != nil {
//                return
//            }
//            
//                let placeHolderView = ds.configEmptyView()!
//                placeHolderView.tag = emptyViewTag
//                addSubview(placeHolderView)
//                placeHolderView.snp.makeConstraints { (make) in
//                    make.edges.equalTo(self)
//                    make.width.height.equalTo(self)
//                }
//        }else {
//            self.viewWithTag(emptyViewTag)?.removeFromSuperview()
//        }
//    }
//}
//

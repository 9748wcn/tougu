//
//  ASBottomAlertView.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/6.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

typealias cellClickBlock = (_ index: NSInteger) -> Void

class ASBottomAlertView: UIView {
    
    let screen_width = UIScreen.main.bounds.width
    let screen_height = UIScreen.main.bounds.height
    
    let tap = UITapGestureRecognizer()
    
    var actionsArray: [String] = []
    var actionsAndBlock: [String : cellClickBlock] = [:]
    
    var alertTitle: String!
    
    fileprivate var tableViewHight: CGFloat {
        return CGFloat(actionsArray.count) * rowHight + headerViewHight + footerViewHight
    }
    fileprivate let rowHight: CGFloat = 50
    fileprivate var headerViewHight: CGFloat {
        if alertTitle.count > 0 {
            return 50
        }else{
            return 0
        }
    }
    fileprivate var footerViewLineHight: CGFloat = 5
    fileprivate var footerViewHight: CGFloat {
        return 50 + footerViewLineHight
    }
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: screen_height, width: self.bounds.width, height: 0), style: .plain)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.hx_registerCell(cellClass: TitleCell.self)
        tableView.backgroundColor = UIColor.white
        
        return tableView
    }()
    
    
    
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        self.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        tap.addTarget(self, action: #selector(dissmiss))
        self.addGestureRecognizer(tap)
        self.addSubview(tableView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dissmiss() {
        UIView.animate(withDuration: 0.25, animations: {
            var frame = self.tableView.frame
            frame.origin.y = self.screen_height
            self.tableView.frame = frame
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
        
    }
    
    public func addAction(_ title: String, block: @escaping (_ index: NSInteger) -> Void) {
        actionsArray.append(title)
        actionsAndBlock[title] = block
        changeTableContent(actionArray: actionsArray)
    }
    
    func changeTableContent(actionArray: Array<String>) {
        tableView.bounds.size.height = CGFloat(actionArray.count * 50)
        tableView.reloadData()
    }
    
    public func showInView (bgView: UIView) {
        
        bgView.addSubview(self)
        
        UIView.animate(withDuration: 0.25, animations: {
            var frame = self.tableView.frame
            frame.origin.y = self.screen_height - (CGFloat(self.actionsArray.count * 50) + self.footerViewHight)
            self.tableView.frame = frame
        }) { (_) in
            
        }
    }
    
}

extension ASBottomAlertView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as TitleCell
        cell.titleLabel.text = actionsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = actionsArray[indexPath.row]
        guard let block = actionsAndBlock[title] else { return }
        block(indexPath.row)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerViewHight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: screen_width, height: footerViewHight))
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: screen_width, height: footerViewLineHight))
        lineView.backgroundColor = UIColor.lightGray
        footerView.addSubview(lineView)
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: footerViewLineHight, width: screen_width, height: footerViewHight-footerViewLineHight)
        footerView.addSubview(btn)
        btn.setTitle("取消", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(dissmiss), for: .touchUpInside)
        
        return footerView;
    }
    
    
}

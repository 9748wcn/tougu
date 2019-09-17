//
//  UpdateAlertView.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class UpdateAlertView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var contentTableView: UITableView!
    
    var contentArray:Array<String>? {
        didSet {
            updateSelfHeight(count: contentArray!.count)
            contentTableView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.hx_registerCell(cellClass: UpdateVersionCell.self)
        contentTableView.rowHeight = UITableView.automaticDimension
        contentTableView.estimatedRowHeight = 20
        contentTableView.separatorStyle = .none
    }
    
    func updateSelfHeight(count: Int) {
        var selfFrame: CGRect = self.frame
        selfFrame.size.height = CGFloat(280 + (count * 15))
        self.frame = selfFrame
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 40))
        let markLabel: UILabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 20))
        markLabel.textAlignment = .center
        markLabel.text = "发现新版本"
        markLabel.font = UIFont.systemFont(ofSize: 18)
        headerView.addSubview(markLabel)
        let versionLabel: UILabel = UILabel.init(frame: CGRect(x: 0, y: 28, width: self.bounds.width, height: 12))
        headerView.addSubview(versionLabel)
        versionLabel.textAlignment = .center
        versionLabel.text = "v1.0.0"
        versionLabel.font = UIFont.systemFont(ofSize: 10)
        headerView.backgroundColor = UIColor.white
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 80))
        let updateButton: UIButton = UIButton.init(type: .roundedRect)
        updateButton.backgroundColor = main_buttonColor
        updateButton.frame = CGRect(x: 45, y: 20, width: self.bounds.width - 90, height: 40)
        updateButton.layer.cornerRadius = 20
        updateButton.setTitle("立即更新", for: .normal)
        updateButton.setTitleColor(UIColor.white, for: .normal)
        footView.addSubview(updateButton)
        footView.backgroundColor = UIColor.white
        return footView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contentArray != nil {
            return contentArray!.count
        }else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contentCell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as UpdateVersionCell
        contentCell.numberLabel.text = "\(indexPath.row)" + "、"
        contentCell.contentItemLabel.text = contentArray![indexPath.row]
        return contentCell
    }

}

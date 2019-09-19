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
    weak var delegate: buttonClickDelegate!
    
    var contentArray:Array<String>? {
        didSet {
            updateSelfHeight(array: contentArray!)
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
        contentTableView.isScrollEnabled = false
        contentTableView.backgroundColor = UIColor.white
        
    }
    
    func updateSelfHeight(array: Array<String>) {
        var selfFrame: CGRect = self.frame
        var height: CGFloat = 0
        for item: String in array {
            height = height + getTextHeigh(textStr: item, font: UIFont.systemFont(ofSize: 18), width: screenWidth - 72)
        }
        selfFrame.size.height = CGFloat(280 + height + (CGFloat(array.count) * 5.0))
        self.frame = selfFrame
        
    }
    
    @IBAction func cancleBtnClick(_ sender: Any) {
        delegate.butonClickBy(sender as! UIButton)
    }
    
    @objc func updateButtonClick(sender: UIButton) {
        delegate.butonClickBy(sender)
    }
    
    func getUpdateViewHeight() -> CGFloat {
       return self.frame.size.height
    }
    
    func getTextHeigh(textStr :  String, font : UIFont, width : CGFloat)  -> CGFloat{
        
        let normalText : NSString = textStr as NSString
        
        let size = CGSize(width: width, height:1000)   //CGSizeMake(width,1000)
        
        let dic = NSDictionary(object: font, forKey : kCTFontAttributeName as! NSCopying)
        
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key:Any], context:nil).size
        
        return  stringSize.height
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 50))
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
        updateButton.tag = 10001
        updateButton.addTarget(self, action: #selector(updateButtonClick(sender:)), for: .touchDragInside)
        footView.addSubview(updateButton)
        footView.backgroundColor = UIColor.white
        return footView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
        contentCell.contentItemLabel.text = "\(indexPath.row)" + "." + contentArray![indexPath.row]
        contentCell.selectionStyle = .none
        return contentCell
    }

}

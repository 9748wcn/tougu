//
//  shareCard+Extension.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/7.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import Foundation

extension HomeMineShareCardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 230
        }else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView: shareCardHeaderView = shareCardHeaderView.loadFromXib()
            self.sectionHeaderView = headerView
            return headerView
            
        }else{
            let headerView: UIView = headerViewOfSection2()
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 34
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }else {
            let footView: UILabel = UILabel.init()
            footView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 34)
            footView.textColor = UIColor(rgb: 0x666666)
            footView.text = "-The End-"
            footView.textAlignment = .center
            footView.font = textFont12
            return footView
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let introduceCell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as ShareCardIntroduceCell
            introduceCell.introduceContentLabel.text = "累计从业经验5年，美国留学工作生活经验，知名财经论坛专业撰稿人，擅长中短线操作，为每一位投资者提供最专业的私募基金走势分析及业务咨询! 建议不少于10个字，不超过100个字，一行约20个字，不超过五行文字介绍为佳。默认文案“丰富理财业务经验，为您提供专业理财服务”以产品经理给的为准。"
            introduceCell.selectionStyle = .none
            return introduceCell
        }else{
            var recordCell = tableView.dequeueReusableCell(withIdentifier: "recordCell")
            if recordCell == nil {
                recordCell = RecordTableViewCell.init(style: .default, reuseIdentifier: "recordCell", recordList: ["查看了您的名片","拨打了电话号码","复制了微信号","点击了绑定"])
            }
            recordCell!.selectionStyle = .none
            return recordCell!
        }
    }
    
    
    func headerViewOfSection2() -> UIView {
        let headerView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 80))
        let spaceView: UIView = UIView.init()
        spaceView.backgroundColor = HomeBackground_Color
        headerView.addSubview(spaceView)
        spaceView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 10)
        let headerTitle: UILabel = UILabel.init()
        headerView.addSubview(headerTitle)
        headerTitle.text = "客户路径"
        headerTitle.textColor = text_Color
        headerTitle.font = UIFont.systemFont(ofSize: 15)
        headerTitle.frame = CGRect(x: 15, y: 25, width: view.bounds.width - 50, height: 20)
        let subContent: UILabel = UILabel.init()
        headerView.addSubview(subContent)
        subContent.textColor = Notext_Color
        subContent.text = "分享名片链接后用户的浏览记录，转发后的链接内不显示"
        subContent.font = textFont12
        subContent.frame = CGRect(x: 15, y: 50, width: view.bounds.width - 50, height: 20)
        return headerView
        
    }
}

// MARK - methods
extension HomeMineShareCardViewController {
    
    @objc func editCardClick() {
        let vc:businessCardEditViewController = businessCardEditViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func saveCardClick() {
        let size: CGSize = sectionHeaderView.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale);
        sectionHeaderView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(image,self,nil,nil);
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(save(image:didFinishSavingWithError:contextInfo:)), nil)
        
    }
    
    @objc func save(image:UIImage, didFinishSavingWithError:NSError?,contextInfo:AnyObject) {
        
        if didFinishSavingWithError != nil {
            HDToast.showTextToast(message: "保存失败")
        } else {
            HDToast.showTextToast(message: "保存成功")
        }
    }
    
    @objc func shareCardClick() {
        
    }
}

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
        if section1Values != nil {
            return 2
        }
        return 1
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
//            self.sectionHeaderView = headerView
            if headerModel != nil {
                headerView.updateUI(dataModel: headerModel!)
            }
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
        if section == 1 {
            if section1Values != nil {
                return section1Values!.count
            }else{
                return 0
            }
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let introduceCell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as ShareCardIntroduceCell
            introduceCell.introduceContentLabel.text = section0Value
            introduceCell.selectionStyle = .none
            return introduceCell
        }else{
            let recordCell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as RecordTableViewCell
            if section1Values != nil {
                recordCell.recordList = section1Values![indexPath.row] as UserBehaviourItemModel
            }
            recordCell.selectionStyle = .none
            return recordCell
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
    
    func updateHeaderView(shareModel: shareCardModel) {
        headerModel = shareModel
        section0Value = (shareModel.data?.data?.profile != nil) ? shareModel.data?.data?.profile! : ""
//        self.sectionHeaderView.updateUI(dataModel: shareModel)
        let defaultStand = UserDefaults.standard
        defaultStand.set(shareModel.data?.data?.jobNames!, forKey: USERJOBKEY)
        defaultStand.set(shareModel.data?.data?.employeeName!, forKey: USERNAMEKEY)
        tableView.reloadData()
    }
    
    func updateUserBehaviourUI(userBehaviour: UserBehaviourModel) {
        if userBehaviour.data != nil {
            section1Values = userBehaviour.data
        }
        tableView.reloadData()
        
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
        let shareView:ASUmengshareView = ASUmengshareView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        shareView.shareDelegate = self
        shareView.isTabbar = !isHiddenTabbar
        shareView.showInView(bgView: view)
    }
}

extension HomeMineShareCardViewController: ASShareClickDelegate {
    func wechatShareClick() {
        
        let messegeObject: UMSocialMessageObject = UMSocialMessageObject()
        let shareObjext: UMShareWebpageObject = UMShareWebpageObject.shareObject(withTitle: "名片分享", descr: "这是我的名片，邀您投资理财", thumImage: UIImage(named: "appIcon"))
        let defaultStand = UserDefaults.standard
        let phoneNo = defaultStand.string(forKey: USERPHONEKEY)
        shareObjext.webpageUrl = "http://172.24.19.45:8080/#/" + "?phoneNo=" + phoneNo!
        messegeObject.shareObject = shareObjext
        
//        messegeObject.webpageUrl = ""
        
        UMSocialManager.default()?.share(to: UMSocialPlatformType.wechatSession, messageObject: messegeObject, currentViewController: self, completion: { (data: Any, err: Error) in

            } as? UMSocialRequestCompletionHandler)
    }
    
    func wechatFrendsShareClick() {
        
    }
    
    func QQShareClick() {
        
    }
}

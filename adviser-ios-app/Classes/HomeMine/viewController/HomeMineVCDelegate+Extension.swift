//
//  HomeMineVCDelegate+Extension.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/6.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import Foundation

extension HomeMineViewController: UITableViewDelegate,UITableViewDataSource,buttonClickDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as HomeMineTableViewCell
        cell.cellHeadImage.image = UIImage(named: headImages[indexPath.row])
        cell.cellTitleLabel.text = headTitles[indexPath.row]
        if indexPath.row == headTitles.count - 1 {
            cell.separateLine.isHidden = true
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView: HomeMineHeadView = HomeMineHeadView.loadFromXib()
        headerView.delegate = self
        self.headerView = headerView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let companyVC: CompanyInfoViewController = CompanyInfoViewController()
            companyVC.url = companyShareUrl
            self.navigationController?.pushViewController(companyVC, animated: true)
//            CompanyInfoViewController.showVC(formVC: self, url: companyShareUrl, completion: nil)
        }else if indexPath.row == 1 {
            let settingVC: SettingViewController = SettingViewController()
            self.navigationController?.pushViewController(settingVC, animated: true)
        }else if indexPath.row == 2 {
            let versionVC: VersionViewController = VersionViewController()
            self.navigationController?.pushViewController(versionVC, animated: true)
        }else if indexPath.row == 3 {
            
        }
    }
    
    func butonClickBy(_ sender: UIButton) {
        if sender.tag == 1000 {
            let personVC: PersonInfoViewController = PersonInfoViewController()
            if personInfoModel != nil {
                personVC.dataModel = personInfoModel
            }
            self.navigationController?.pushViewController(personVC, animated: true)
        }else if sender.tag == 1002 {
            //分享我的名片
            let shareCardVC: HomeMineShareCardViewController = HomeMineShareCardViewController()
            shareCardVC.isHiddenTabbar = true
            self.navigationController?.pushViewController(shareCardVC, animated: true)
        }else if sender.tag == 1001 {
            //编辑我的名片
            let vc:BusinessCardEditViewController = BusinessCardEditViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
    
    
}

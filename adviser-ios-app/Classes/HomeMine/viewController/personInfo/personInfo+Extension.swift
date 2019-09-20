//
//  personInfo+Extension.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/6.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import Foundation
import Kingfisher

extension personInfoViewController: UITableViewDelegate,UITableViewDataSource,buttonClickDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 152
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return firstSectionKeys.count
        }else{
            return secondSectionKeys.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as personInfoTableViewCell
            cell.typeLabel.text = firstSectionKeys[indexPath.row]
            cell.typeValueLabel.text = (firstSectionValues?[indexPath.row] != nil) ? firstSectionValues?[indexPath.row] : ""
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.hx_dequeueReusableCell(indexPath: indexPath) as personInfoTableViewCell
            cell.typeLabel.text = secondSectionKeys[indexPath.row]
            cell.typeValueLabel.text = (secondSectionValues?[indexPath.row] != nil) ? secondSectionValues?[indexPath.row] : ""
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView: personInfoHeadView = personInfoHeadView.loadFromXib()
            headerView.delegate = self
            headerBtn = headerView.headerImageBtn
            if dataModel?.data?.avatar != nil {
                let headrurl = URL(string: imageBaseUrl + (dataModel?.data?.avatar!)!)
                headerView.headerImageBtn.kf.setImage(with: ImageResource(downloadURL: headrurl!), for:.normal, placeholder: UIImage(named: "normalHeader"))
            }
            return headerView
        }else{
            let lineView = UIView.init(frame: CGRect(x: 23, y: 0, width: view.bounds.width - 46, height: 1))
            lineView.backgroundColor = lightSeparate_Color
            return lineView
        }
        
    }
    
    func butonClickBy(_ sender: UIButton) {
        //唤起拍照
        let acVC = ActionSheetViewController(cellTitleList: ["拍照", "从手机相册选择"])!
        acVC.valueBlock = { index in
            if index == 0 {
                self.getHeaderByPhoto()
            }else if index == 1 {
                self.getHeaderByLibrary()
            }
        }
        present(acVC, animated: false, completion:  nil)
        
    }
    
    func getHeaderByLibrary() {
        HDPhotoImageManager.getPhotoLibraryAuthorization { [unowned self](bool) in
            guard bool, UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                return
            }
            UIImagePickerController.rx.createWithParent(self) { picker in
                picker.sourceType = .photoLibrary
                picker.modalPresentationStyle = .overCurrentContext
                }
                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .map {
                    
                    let image  =  $0[.originalImage] as! UIImage
                    let que = DispatchQueue.global(qos: .default)
                    que.async {
                        let defaultStand = UserDefaults.standard
                        UploadImageManager.shared.uploadImage(vc: self, image: image, phoneNo: defaultStand.string(forKey: USERPHONEKEY)!)
                    }
                    return image
                }
                .bind(to: self.headerBtn.rx.image())
                .disposed(by: self.disposeBag)
        }
    }
    
    func getHeaderByPhoto() {
        HDPhotoImageManager.getCameraAuthorization { [unowned self](bool) in
            guard bool, UIImagePickerController.isSourceTypeAvailable(.camera) else {
                return
            }
            UIImagePickerController.rx.createWithParent(self) { picker in
                picker.sourceType = .camera
                picker.modalPresentationStyle = .overCurrentContext
                }.flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .map{
                    
                    let image  =  $0[.originalImage] as! UIImage
                    let que = DispatchQueue.global(qos: .default)
                    que.async {
                        let defaultStand = UserDefaults.standard
                        UploadImageManager.shared.uploadImage(vc: self, image: image, phoneNo: defaultStand.string(forKey: USERPHONEKEY)!)
                    }
                    return image
                }
                .bind(to: self.headerBtn.rx.image())
                .disposed(by: self.disposeBag)
            
        }
    }
    
}

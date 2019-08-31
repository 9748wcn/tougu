//
//  HDImagePickerViewController.swift
//  mgr-combat-map-ios
//
//  Created by chenwuqi on 2019/5/13.
//  Copyright © 2019 evergrande_caifu_manager. All rights reserved.
//

import UIKit


import Photos

// MARK: -  代理
@objc protocol HDImagePickerViewControllerDelegate: class {
    
    /// 取消选择
    @objc optional func imagePickerControllerDidCancelSelect(_ imagePickerController: HDImagePickerViewController)
    
    /// 选择完成
    ///
    /// - Parameters:
    ///   - imagePickerController: 回调者本身
    ///   - imageModels: 图片模型
    ///   - isOrigin: 是否选择原图
    @objc optional func imagePickerController(_ imagePickerController: HDImagePickerViewController, didSelected imageModel: HDImageModel, isThumb: Bool)
    
    /// 选择完成
    ///
    /// - Parameters:
    ///   - imagePickerController: 回调者本身
    ///   - images: 图片数组
    @objc optional func imagePickerController(_ imagePickerController: HDImagePickerViewController, didSelected image: UIImage)
}


class HDImagePickerViewController: UINavigationController {
    /// 选择媒体类型
    var mediaTypes: [PHAssetMediaType] = [.video, .image]
    
    /// 回调代理
    weak var hd_delegate: HDImagePickerViewControllerDelegate?
    /// 已选中数组
    var selectedImageModel: HDImageModel?
    
    /// 是否选中原图
    var isThumb: Bool = false
    
    init() {
        let rootVC = HDAlbumListViewController()
        super.init(rootViewController: rootVC)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarUI()
    }
    
    private func setupNavigationBarUI() {
        navigationBar.tintColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        navigationBar.shadowImage = UIImage()
    }
    
    // MARK: -  Public Methods
    
    /// 取消
    func cancelSelect() {
        hd_delegate?.imagePickerControllerDidCancelSelect?(self)
        dismiss(animated: true, completion: nil)
    }

    
    /// 选择完成
    func didSelectedImageModel(imageModel: HDImageModel) {
        hd_delegate?.imagePickerController?(self, didSelected: imageModel, isThumb:isThumb)
        if hd_delegate?.imagePickerController(_:didSelected:) != nil {
            DispatchQueue.global().async {
                if self.isThumb {
                    HDPhotoImageManager.requestThumbImage(for: imageModel.phAsset) { (image, finished) in
                        self.didSelectedImage(image: image)
                            
                        }
                    }else {
                    HDPhotoImageManager.requestOriginImage(for: imageModel.phAsset) { (image, finished) in
                         self.didSelectedImage(image: image)
                        }
                    }
                
            }
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
   
    func didSelectedImage(image:UIImage?=nil) {
        DispatchQueue.main.async {
            if let image = image {
                self.hd_delegate?.imagePickerController?(self, didSelected: image)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    /// 弹出前往设置授权提示框
    func showAuthorizationAlert() {
        let title = "请开启照片权限"
        let message = "相册权限未开启,请进入系统设置>隐私>照片中打开开关,并允许使用照片权限"
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        let callAction = UIAlertAction(title: "立即设置", style: .default) { (action) in
            guard let url = URL(string: UIApplication.openSettingsURLString),
                UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.openURL(url)
        }
        alertVC.addAction(cancelAction)
        alertVC.addAction(callAction)
        present(alertVC, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

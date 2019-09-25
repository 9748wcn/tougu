//
//  UploadImageManager.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/18.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class UploadImageManager: NSObject,HDAsyncDelegate {
//    static let shared = UploadImageManager()
    var vc:BaseViewController!
    
    override init() {
        super.init()
    }
    
    func uploadImage(vc: BaseViewController, image: UIImage,phoneNo: String) {
        
        self.vc = vc
//        let data: NSData = image.pngData()! as NSData
        let data: NSData = image.jpegData(compressionQuality: 0.7)! as NSData
        let api = UploadImageProto()
        api.phoneNo = phoneNo
        api.method = .post
        api.imageType = 1
        api.portraitImage = data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0)))
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.tag = "1000"
        request.start()
        
    }
    
    func uploadBussinessCardHeader(vc: BaseViewController, image: UIImage,phoneNo: String) {
        self.vc = vc
        let data: NSData = image.jpegData(compressionQuality: 0.7)! as NSData
        //        let data: NSData = image.jpegData(compressionQuality: 0.7)! as NSData
        let api = UploadEditCardHeaderProto()
        api.phoneNo = phoneNo
        api.method = .post
        api.imageType = 1
        api.portraitImage = data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0)))
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.tag = "1001"
        request.start()
    }
    
    func asyncerDidStart(request: HDHTTPRequest) {
        HDHudManager.shared.show()
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
        HDHudManager.shared.hide()
        if request.tag == "1000" {
            let model = result as? HDBaseModel
            if model?.code == 1 {
                if model?.message != nil {
                    HDToast.showTextToast(message: model?.message!)
                }
            }else {
                HDToast.showTextToast(message: "图片上传失败")
            }
        }else {
            
            let model = result as? UploadCardHeaderModel
            if model?.code == 1 {
                //布局界面
                if let editCardVC = self.vc as? BusinessCardEditViewController {
                    editCardVC.contentArr[0][0] = model?.avatar ?? ""
                }
            }
            
        }
        
    }
    
    func asyncerdidFailWithError(request: HDHTTPRequest, error: NSError) {
        HDHudManager.shared.hide()
        HDToast.showTextToast(message: "图片上传失败")
        
    }

}

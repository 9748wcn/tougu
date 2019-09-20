//
//  VersionValueManager.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/17.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class VersionValueManager: NSObject, HDAsyncDelegate,UpdateViewDelegate {
    
    static let shared = VersionValueManager()
    var vc:baseViewController!
    var updateModel: VersionModel?
    
    func getVersionValue(vc: baseViewController) {
        self.vc = vc
        let api = VersionValueProto()
        api.method = .get
        let request = HDHTTPRequest()
        request.api = api
        request.delegate = self
        request.start()
    }
    
    func asyncerDidStart(request: HDHTTPRequest) {
        HDHudManager.shared.show()
    }
    
    func asyncerdidFinishWithResult(request: HDHTTPRequest, result: AnyObject) {
        HDHudManager.shared.hide()
        let model = result as? VersionModel
        if model?.code == 1 && ((model?.data) != nil) {
            updateModel = model
            var versionLocal: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
            versionLocal = "0.0.1"
            let shouUpdate:Bool = compareVersions(v1: model!.data?.versionName, v2: versionLocal)
            if shouUpdate {
                let contentArray: Array<String> = (model!.data?.profile?.components(separatedBy: "/"))!
//
                let alertUpdate: UpdateViewController = UpdateViewController.init(cellContent: contentArray)!
                if model!.data?.flag == "true" {
                    alertUpdate.isforce = true
                }else {
                    alertUpdate.isforce = false
                }
                alertUpdate.versionValue = (model?.data?.versionName!)!
                alertUpdate.delegate = self
                self.vc.present(alertUpdate, animated: true, completion: nil)
            }
            //布局界面
//            if let versionVC = self.vc as? VersionViewController {
//                versionVC.updateVersion(versionModel: model!)
//            }
        }
    }
    
    func asyncerdidFailWithError(request: HDHTTPRequest, error: NSError) {
        
    }
    
    func updateVersion(_ sender: UIButton) {
        if UIApplication.shared.canOpenURL(URL(string: updateModel!.data!.iosAddress!)!) {
            
            UIApplication.shared.openURL(URL(string: updateModel!.data!.iosAddress!)!)
        }
    }
    
    /// 比较版本大小，返回是否需要更新
    ///
    /// - Parameters:
    ///   - v1: 版本1- 新版本
    ///   - v2: 版本2- 当前版本
    /// - Returns: true：v1>v2    false:v1<=v2
    func compareVersions(v1:String?,v2:String) -> Bool {
        if v1 == nil {
            return false
        }
        if v1!.isEmpty && v2.isEmpty || v1!.isEmpty{
            return false
        }
        
        if v2.isEmpty {
            return true
        }
        
        let arry1 = v1!.components(separatedBy: ".")
        let arry2 = v2.components(separatedBy: ".")
        //取count少的
        let minCount = arry1.count > arry2.count ? arry2.count : arry1.count
        
        var value1:Int = 0
        var value2:Int = 0
        
        for i in 0..<minCount {
            if !isPurnInt(string: arry1[i]) || !isPurnInt(string: arry2[i]){
                return false
            }
            
            value1 = Int(arry1[i])!
            value2 = Int(arry2[i])!
            
            // v1版本字段大于v2版本字段
            if value1 > value2 {
                // v1版本字段大于v2版本字段
                return true
            }else if value1 < value2{
                // v1版本字段小于v2版本字段
                return false
            }
            // v1版本=v2版本字段  继续循环
            
        }
        
        //字段多的版本高于字段少的版本
        if arry1.count > arry2.count {
            return true
        }else if arry1.count <= arry2.count {
            return false
        }
        
        return false
    }
    
    /// 判断是否是数字
    ///
    /// - Parameter string: <#string description#>
    /// - Returns: <#return value description#>
    func isPurnInt(string: String) -> Bool {
        let scan: Scanner = Scanner(string: string)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }

}

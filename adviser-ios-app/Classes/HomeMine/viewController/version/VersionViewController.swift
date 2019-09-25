//
//  VersionViewController.swift
//  adviser-ios-app
//
//  Created by HDCF001 on 2019/9/10.
//  Copyright © 2019 HDCF001. All rights reserved.
//

import UIKit

class VersionViewController: BaseViewController {
    @IBOutlet weak var checkVersionBtn: UIButton!
    
    
    
    
    @IBOutlet weak var versionLabel: UILabel!
    let versionLocal: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "版本信息"
        checkVersionBtn.layer.cornerRadius = 22.5
        checkVersionBtn.layer.borderColor = main_buttonColor.cgColor
        checkVersionBtn.layer.borderWidth = 1.0
        checkVersionBtn.setTitleColor(main_buttonColor, for: .normal)
        checkVersionBtn.backgroundColor = UIColor.white
        
        versionLabel.text = "V" + versionLocal
    }

    @IBAction func checkVersionClick(_ sender: Any) {
        VersionValueManager().getVersionValue(vc: self)
    }
    
//    func updateVersion(versionModel: VersionModel) {
//        updateModel = versionModel
////        let versionLocal: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
//        let shouUpdate:Bool = compareVersions(v1: versionModel.data?.versionName, v2: versionLocal)
//        if shouUpdate {
//            let contentArray: Array<String> = (versionModel.data?.profile?.components(separatedBy: "/"))!
//
//            let alertUpdate: UpdateViewController = UpdateViewController.init(cellContent: contentArray)!
//            if versionModel.data?.flag == "true" {
//                alertUpdate.isforce = true
//            }else {
//                alertUpdate.isforce = false
//            }
//            alertUpdate.delegate = self
//            self.present(alertUpdate, animated: true, completion: nil)
//        }else {
//            HDToast.showTextToast(message: "无新版本")
//        }
    
//    }
    
//    func updateVersion(_ sender: UIButton) {
//
//        if UIApplication.shared.canOpenURL(URL(string: updateModel!.data!.iosAddress!)!) {
//
//            UIApplication.shared.openURL(URL(string: updateModel!.data!.iosAddress!)!)
//        }
//    }

    /// 比较版本大小，返回是否需要更新
    ///
    /// - Parameters:
    ///   - v1: 版本1- 新版本
    ///   - v2: 版本2- 当前版本
    /// - Returns: true：v1>v2    false:v1<=v2
//    func compareVersions(v1:String?,v2:String) -> Bool {
//        if v1 == nil {
//            return false
//        }
//        if v1!.isEmpty && v2.isEmpty || v1!.isEmpty{
//            return false
//        }
//
//        if v2.isEmpty {
//            return true
//        }
//
//        let arry1 = v1!.components(separatedBy: ".")
//        let arry2 = v2.components(separatedBy: ".")
//        //取count少的
//        let minCount = arry1.count > arry2.count ? arry2.count : arry1.count
//
//        var value1:Int = 0
//        var value2:Int = 0
//
//        for i in 0..<minCount {
//            if !isPurnInt(string: arry1[i]) || !isPurnInt(string: arry2[i]){
//                return false
//            }
//
//            value1 = Int(arry1[i])!
//            value2 = Int(arry2[i])!
//
//            // v1版本字段大于v2版本字段
//            if value1 > value2 {
//                // v1版本字段大于v2版本字段
//                return true
//            }else if value1 < value2{
//                // v1版本字段小于v2版本字段
//                return false
//            }
//            // v1版本=v2版本字段  继续循环
//
//        }
//
//        //字段多的版本高于字段少的版本
//        if arry1.count > arry2.count {
//            return true
//        }else if arry1.count <= arry2.count {
//            return false
//        }
//
//        return false
//    }
//
//    /// 判断是否是数字
//    ///
//    /// - Parameter string: <#string description#>
//    /// - Returns: <#return value description#>
//    func isPurnInt(string: String) -> Bool {
//        let scan: Scanner = Scanner(string: string)
//        var val:Int = 0
//        return scan.scanInt(&val) && scan.isAtEnd
//    }
//

}

//
//  HDBaseApi.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/2.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit
import Alamofire

import HandyJSON

typealias HD_Api_Parameters = [String:Any]

protocol HDBaseApiProtocol {
    //属性
    var urlString:String { get set }
    var method:HTTPMethod { get set }
    var httpHeaders:[String:String] { get set }
    var apiType:HDApiType { get set }
    var requestWithoutCookie: Bool { get set }
    var multipartFormDataBlock:MultipartFormDataBlock? { get set }
    
    // 这里是协议的定义部分
    func responseObjectFromJson<T: HDBaseModel>(jsonStr : String) -> T
    func getParameters() -> HD_Api_Parameters?
}

enum HDApiType {
    case normal
    case setting
}

public typealias MultipartFormDataBlock = (MultipartFormData) -> Void;

class HDBaseApi: HDBaseApiProtocol {
    
    var method: HTTPMethod
    var multipartFormDataBlock: MultipartFormDataBlock?
    var urlString: String
    var apiType: HDApiType
    var httpHeaders:[String:String]
    var requestWithoutCookie: Bool
     init() {
        urlString = ""
        method = .post
        httpHeaders = ["Content-Type":"application/json"]
        apiType = .normal
        multipartFormDataBlock = nil
        requestWithoutCookie = false
    }

    func getClassName() -> String {
        return "\(type(of: self))"
    }
    
    func getParameters() -> HD_Api_Parameters? {
//        fatalError("Must Override")
        return nil
    }
    
    func responseObjectFromJson<T>(jsonStr: String) -> T where T : HDBaseModel {
        fatalError("Must Override")
    }
    
}

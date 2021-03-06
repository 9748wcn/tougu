//
//  HDHTTPRequest.swift
//  mgr-combat-map-ios
//
//  Created by hengda on 2019/4/9.
//  Copyright © 2019 Chen Nate. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

 protocol HDAsyncDelegate {
    
    func asyncerDidStart(request:HDHTTPRequest)
    func asyncerdidFinishWithResult(request:HDHTTPRequest,result:AnyObject)
    func asyncerdidFailWithError(request:HDHTTPRequest,error:NSError)
}
//    let baseUrl:String = "http://172.24.19.132:8749"
//let baseUrl:String = "http://172.16.81.184:8749"
let baseUrl:String = "http://172.16.81.202:8749"
let imageBaseUrl:String = "https://iqfdfs.hdfax.com/"
let shareCardUrl:String = "http://172.16.81.184:80"
let companyShareUrl:String = "http://172.16.81.184:80/#/hdIfon"
//    let baseSettingUrl:String = "http://17391l3n18.imwork.net"
let baseSettingUrl:String = ""
//let baseUrl:String = "http://172.16.40.34:8082"
class HDHTTPRequest {
    
    enum HDRequestError: Error {
        case unknownError
        case connectionError
        case authorizationError(JSON)
        case serverError
        case parseError
    }
    
    enum HDApiResult {
        case success(String)
        case failure(HDRequestError)
    }
    
    
    var api:HDBaseApi!
    var request:URLRequest?
    var delegate:HDAsyncDelegate?
    var dataTask:URLSessionDataTask?
    var tag:String = ""
    
    func start() {
        var url:String = ""
        if api.apiType == .normal {
            url = baseUrl + api.urlString
        }else {
             url = baseSettingUrl + api.urlString
        }
        if api.method == .get {
            url = getAppendUrl(url: url, aa: api.getParameters()!)
        }
       
        var urlRequest = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        if api.method != .get {
            if let param = api.getParameters() {
                let jsonData = try? JSONSerialization.data(withJSONObject: param)
                urlRequest.httpBody = jsonData
                print("param = \(param)")
            }
        }
        for (key,value) in api.httpHeaders {
            urlRequest.setValue(value, forHTTPHeaderField:key)
        }
        urlRequest.httpMethod = api.method.rawValue
        
        //print(url,api.getParameters(),urlRequest.httpMethod)
        dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
                self.performApiResponse(.failure(.connectionError))
            }else if let data = data ,let responseCode = response as? HTTPURLResponse {
                do {
                    //只要符合String.Encoding.utf8这种编码的data都能转化成功
                    let jsonStr = String(data: data, encoding: String.Encoding.utf8)
                    let responseJson = try JSON(data: data)
                    
                    HDLog("responseJSON : \(responseJson)")
                    switch responseCode.statusCode {
                    case 200:
//                        if !self.jsonCheck(json: responseJson) {
//                            self.performApiResponse(.failure(.parseError))
//                            return
//                        }

                        self.performApiResponse(.success(jsonStr!))
                    case 400...499:
                        self.performApiResponse(.failure(.authorizationError(responseJson)))
                    case 500...599:
                        self.performApiResponse(.failure(.serverError))
                    default:
                        self.performApiResponse(.failure(.unknownError))
                        break
                    }
                }
                catch let parseJSONError {
                    HDLog("error on parsing request to JSON : \(parseJSONError)")
                    self.performApiResponse(.failure(.unknownError))
                }
            }
        }
        dataTask?.resume()
        self.delegate?.asyncerDidStart(request: self)
    }
    
    
    func performApiResponse(_ result:HDApiResult) {
        DispatchQueue.main.async {
            
            switch result {
            case .success(let jsonStr):
                let model = self.api.responseObjectFromJson(jsonStr:jsonStr)
                switch model.code {
                case 0:
                    HDToast.showTextToast(message: model.message)
                    self.performFailure(code: model.code,errorMessage: model.message)
                case 1:
                    self.performSuccess(model: model)
                case 1001:
                    HDToast.showTextToast(message: model.message)
                    self.performFailure(code: model.code,errorMessage: "手机号已注册")
                case 1002:
                    HDToast.showTextToast(message: model.message)
                    self.performFailure(code: model.code,errorMessage: "手机号未注册")
                case 1003:
                    HDToast.showTextToast(message: model.message)
                    self.performFailure(code: model.code,errorMessage: "Token失效，请重新登录")
                case 1004:
                    HDToast.showTextToast(message: model.message)
                    self.performFailure(code: model.code,errorMessage: "Token失效，请重新登录")
                case 5001:
                    HDToast.showTextToast(message: model.message)
                    self.performFailure(code: model.code,errorMessage: "未知错误")
                    
                case 5002:
                    HDToast.showTextToast(message: model.message)
                    self.performFailure(code: model.code,errorMessage: "系统错误")
                    
                default:
                    HDToast.showTextToast(message: "系统异常")
                    self.performFailure(code: model.code,errorMessage: "系统异常")
                }
            case .failure(let failure) :
                HDHudManager.shared.hide()
                switch failure {
                case .connectionError:
                    HDToast.showTextToast(message: "网路异常")
                    self.performFailure(code: 1,errorMessage: "系统异常")
                case .authorizationError(let errorJson):
                    HDToast.showTextToast(message: errorJson["message"].stringValue)
                case .serverError:
                    HDToast.showTextToast(message: "服务器异常")
                case .unknownError:
                    HDToast.showTextToast(message: "未知错误")
                case .parseError:
                    HDToast.showTextToast(message: "数据异常")
                }
            }
        }
    }
    
    
    func performSuccess(model:HDBaseModel) {
        self.delegate?.asyncerdidFinishWithResult(request:self, result: model)
    }

    func performFailure(code:Int,errorMessage:String?) {
        var userInfo:[String:String] = Dictionary()
        userInfo[NSLocalizedFailureReasonErrorKey] = errorMessage;
        let error:NSError = NSError.init(domain: api.getClassName(), code: code, userInfo: userInfo)
        HDHudManager.shared.hide()
        self.delegate?.asyncerdidFailWithError(request: self, error: error)
        if code == 1004{
            appDelegate.gotoLogin()
        }
    }
    
    func jsonCheck(json:JSON) -> Bool {
        let data = json["data"]
        if data.type == .array {
            return true;
        }
        if data.count > 0 {
            return true
        }
        return false
    }
    
    /**
     * @Description get请求URL拼接参数
     * @param url
     *            接口地址(无参数)
     * @param map
     *            拼接参数集合
     */
    func getAppendUrl(url: String, aa: [String:Any]) -> String {
        if aa.isEmpty {
            return url + ""
        }
        let array = aa.keys
        let strArr = array.map { (value) -> String in
            return String(format:"%@=%@",value,String(describing: aa[value]!))
        }
        let str = strArr.joined(separator: "&")
        print("get param \(url + "?" + str)")
        return url + "?" + str
   }
    
    
    func cancel() {
        self.dataTask?.cancel()
    }
    
    deinit {
        
    }
}


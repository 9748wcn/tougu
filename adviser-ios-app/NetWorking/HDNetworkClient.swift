//
//  HDNetworkClient.swift
//  RxSwiftProject
//
//  Created by HDCF003 on 2019/7/25.
//  Copyright © 2019 HDCF003. All rights reserved.
//
import Moya
import RxSwift
import HandyJSON
import Foundation

enum RxSwiftMoyaError{
    case ParseJSONError
    case UnknownError
    case ServerError
    case CustomError(msg:String,code:Int)
}
extension RxSwiftMoyaError: Swift.Error {
    func show() {
        switch self {
        case let .CustomError(msg, _):
            HDToast.showTextToast(message: msg)
        case .ParseJSONError:
            HDToast.showTextToast(message: "数据异常")
        case .UnknownError:
            HDToast.showTextToast(message: "未知错误")
        case .ServerError:
            HDToast.showTextToast(message: "服务器异常")
        }
    }
}

protocol LightError: Error {
    var errorMessage: String { get }
}

extension Error {
    var errorMessage: String {
        if let error = self as? LightError {
            return error.errorMessage
        }
        return "未知错误"
    }
}


class HDNetworkClient {
    static  func request<H: HandyJSON, T: TargetType>(_ type: T, _ model: H.Type) -> Observable<H> {
        let mp = MoyaProvider<T>(plugins:[
                NetworkLoggerPlugin(verbose: false),
                NetworkActivityPlugin { (networkType, _) in
                    if networkType == .began {
                        HDHudManager.shared.show()
                        UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    }else{
                       HDHudManager.shared.hide()
                       UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                }
            ])
        let ob = mp
            .rx.request(type)
            .asObservable()
            .map(model)
            .catchError {
                if let error = $0 as? RxSwiftMoyaError {
                    error.show()
                }else{
                    HDToast.showTextToast(message: "网络异常")
                }
                return .error($0)
        }
        return ob
    }
}


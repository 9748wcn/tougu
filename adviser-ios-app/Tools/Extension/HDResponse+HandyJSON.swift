//
//  HDResponse+HandyJSON.swift
//  mgr-combat-map-ios
//
//  Created by HDCF003 on 2019/7/29.
//  Copyright © 2019 evergrande_caifu_manager. All rights reserved.
//
import Moya
import RxSwift
import HandyJSON
import Foundation

extension Observable {
    func map<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return map { response in
            guard let response = response as? Moya.Response else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            guard (200...209) ~= response.statusCode else {
                throw RxSwiftMoyaError.ServerError
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            let code = json["code"] as? Int
            let msg  = json["errMessage"] as? String
            guard let codeNet = code, codeNet == 1 else{
                throw RxSwiftMoyaError.CustomError(msg: msg ?? "未知错误", code: code ?? 0)
            }
            
            let object = JSONDeserializer<T>.deserializeFrom(dict: json)
            guard let model = object else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            return model
        }
    }
}

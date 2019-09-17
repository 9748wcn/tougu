//
//  HDNetworkAPI.swift
//  mgr-combat-map-ios
//
//  Created by HDCF003 on 2019/7/29.
//  Copyright © 2019 evergrande_caifu_manager. All rights reserved.
//

import Moya
import Foundation
enum HDNetworkAPI {
    //主页
    case mainPage(rformType:String)
    //团队排名
    case teamRank(paramer:[String:String])
    //团队详情
    case teamDetail(rformType:String,departmentSn:String)
    //投顾排名
    case investRank(paramer:[String:String])
    //投顾信息
    case investDetail(rformType:String,employeeNumber:String)
}
extension HDNetworkAPI:Moya.TargetType {
    var baseURL: URL {
        return URL(string: "http://combatmap.hdfax.com")!
    }
    
    var path: String {
        switch self {
        case .mainPage:
            return "/team_rank/getTeamRankFacade"
        case .teamRank:
            return "/team_rank/getTeamRank"
        case .teamDetail:
            return "/team_rank/getTeamRankDetail"
        case .investRank:
            return "/rank/getEmployeeRankRFormSort"
        case .investDetail:
            return "/rank/getEmployeeRankRForm"
        }
    }
    var method: Moya.Method {
        return .post
    }
    var sampleData: Moya.Data {
        return "".data(using: String.Encoding.utf8)!
    }
    var task: Moya.Task {
        switch self {
        case let .mainPage(rformType):
            var paramer:[String:Any] = ["rformType":rformType]
            paramer = addUserName(with: paramer)
            return .requestParameters(parameters: paramer, encoding: JSONEncoding.default)
        case  .teamRank(let paramer),  .investRank(let paramer):
            var paramer:[String:Any] = paramer
            paramer = addUserName(with: paramer)
            return .requestParameters(parameters: paramer, encoding: JSONEncoding.default)
        case let .teamDetail(rformType, departmentSn):
            var paramer:[String:Any] = ["rformType":rformType,"departmentSn":departmentSn]
            paramer = addUserName(with: paramer)
            return .requestParameters(parameters: paramer, encoding: JSONEncoding.default)
        case let .investDetail(rformType,employeeNumber):
            var paramer:[String:Any] = ["rformType":rformType,"employeeNumber":employeeNumber]
            paramer = addUserName(with: paramer)
            return .requestParameters(parameters: paramer, encoding: JSONEncoding.default)
        }
    }
    var headers: [String : String]? {
        return ["Content-type": "application/json"];
    }
}

extension HDNetworkAPI {
    func addUserName(with dict:[String:Any]) -> [String:Any] {
        var paramer = dict
//        if let username = HDUserDefaults.hd_getCurrentUser() {
//            paramer["username"] = username
//        }
        return paramer
    }
}

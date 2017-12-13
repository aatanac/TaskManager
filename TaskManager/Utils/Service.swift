//
//  Service.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/13/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import Moya

enum Service {
    case userRegister(id: String, email: String)
    case userLogin(id: String, email: String)
    case user(method: Moya.Method, userID: Int)
    case users
}

extension Service: TargetType {

    private static let accessToken = ""

    var sampleData: Data {
        return Data()
    }

    var headers: [String : String]? {
        var header = ["Content-type": "application/json"]
        switch self {
        case .userLogin(id: _, email: _), .userRegister(id: _, email: _):
            return header
        case .users, .user(method: _, userID: _):
            header["Authorization"] = Service.accessToken
            return header
        }
    }

    var baseURL: URL {
        return URL(string:"https://ios.atmdev.com/v1/")!
    }

    var path: String {
        switch self {
        case .user(method: _, userID: let id):
            return "users/\(id)"
        case .users:
            return "users"
        case .userRegister(id: _, email: _):
            return "users/add"
        case .userLogin(id: _, email: _):
            return "users/auth"
        }
    }

    var method: Moya.Method {
        switch self {
        case .user(method: let method, userID: _):
            return method
        case .users:
            return .get
        case .userRegister(id: _, email: _):
            return .post
        case .userLogin(id: _, email: _):
            return .post
        }
    }

    var task: Task {
        switch self {
        case .user(method: _, userID: _):
            return .requestPlain
        case .users:
            return .requestPlain
        case .userRegister(id: let id, email: let email):
            return .requestParameters(parameters: ["id": id, "email": email], encoding: JSONEncoding.default)
        case .userLogin(id: let id, email: let email):
            return .requestParameters(parameters: ["id": id, "email": email], encoding: JSONEncoding.default)
            //return .requestParameters(parameters: ["id":id], encoding: JSONEncoding.default)
        }
    }

}

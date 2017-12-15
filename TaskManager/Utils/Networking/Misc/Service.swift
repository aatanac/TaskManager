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
    case tasks
}

extension Service: TargetType {

    // access token used as user name
    static let username = "twp_37mDj6P5VRiC11wDz3s3342sK8iE"
    // password can be anything
    static let password = "test"

    var sampleData: Data {
        return Data()
    }

    var headers: [String : String]? {
        let header = ["Content-type": "application/json"]
        switch self {
        case .tasks:
            return header
        }
    }

    var baseURL: URL {
        return URL(string:"https://aatanac.teamwork.com")!
    }

    var path: String {
        switch self {
        case .tasks:
            return "/tasks.json"
        }
    }

    var method: Moya.Method {
        switch self {
        case .tasks:
            return Moya.Method.get
        }
    }

    var task: Task {
        switch self {
        case .tasks:
            return .requestPlain
        }
    }

}

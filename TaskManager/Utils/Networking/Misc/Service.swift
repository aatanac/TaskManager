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
    case tasks(params: [String: Any]?)
    case taskLists(projectID: String?)
    case tasksEdit(method: Moya.Method, taskListID: Int, params: [String: Any])
    case projects(params: [String: Any])
    case user
}

extension Service: TargetType {

    // access token used as user name
    static let username = "twp_TEbBXGCnvl2HfvXWfkLUlzx92e3T"
    // password can be anything
    static let password = "test"

    var sampleData: Data {
        let postData = try? JSONSerialization.data(withJSONObject: self.sampleJson, options: .prettyPrinted)
        if let data = postData {
            return data
        }
        assertionFailure("Data not valid")
        return Data()
    }

    var headers: [String : String]? {
        let header = ["Content-type": "application/json"]
        switch self {
        case .tasks(params: _):
            return header
        case .projects(params: _):
            return header
        case .tasksEdit(method: _, taskListID: _, params: _):
            return header
        case .user:
            return header
        case .taskLists(projectID: _):
            return header
        }
    }

    var baseURL: URL {
        return URL(string:"https://yat.teamwork.com")!
    }

    var path: String {
        switch self {
        case .tasks(params: _):
            return "/tasks.json"
        case .projects(params: _):
            return  "/projects.json"
        case .tasksEdit(method: _, taskListID: let ID, params: _):
            return "/tasklists/\(ID)/tasks.json"
        case .user:
            return "/me.json"
        case .taskLists(projectID: let ID):
            if let projectID = ID {
                return "/projects/\(projectID)/tasklists.json"
            } else {
                return "/tasklists.json"
            }
        }
    }

    var method: Moya.Method {
        switch self {
        case .tasks(params: _):
            return Moya.Method.get
        case .projects(params: _):
            return Moya.Method.get
        case .tasksEdit(method: let method, taskListID: _, params: _):
            return method
        case .user:
            return Moya.Method.get
        case .taskLists(projectID: _):
            return Moya.Method.get
        }
    }

    var task: Task {
        switch self {
        case .tasks(params: let params):
            if let parameters = params {
                return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            }
            return .requestPlain
        case .projects(params: let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .tasksEdit(method: _, taskListID: _, params: _):
            return .requestParameters(parameters: self.sampleJson, encoding: JSONEncoding.default)
        case .user:
            return .requestPlain
        case .taskLists(projectID: _):
            // hardcoded for simplicity
            return .requestParameters(parameters: ["status": "active"], encoding: URLEncoding.queryString)
        }
    }

}

extension Service {

    var sampleJson: [String: Any] {
        switch self {
        case .tasksEdit(method: _, taskListID: _, params: _):
            return
                ["todo-item": [
                    "content": "Test Task",
                    "notify": true,
                    "description": "Test Task Sub Item",
                    "due-date": "20140405",
                    "start-date": "20140402",
                    "estimated-minutes": "0",
                    "private": false,
//                    "grant-access-to": "",
                    "priority": "low",
                    "progress": "20",
                    "attachments": [],
                    "pendingFileAttachments": "",
                    "responsible-party-id": "",
                    "predecessors": [
                        [
                            "id": 439492,
                            "type": "complete"
                        ]
                    ],
                    "tags": "api,documentation",
                    "positionAfterTask": -1
                ]]
        default:
            return [:]
        }

    }

}

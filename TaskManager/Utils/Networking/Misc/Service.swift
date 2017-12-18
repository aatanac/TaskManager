//
//  Service.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/13/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import Moya

// if app would grow it would be implemented multiple service for separation of logic
enum Service {
    // all fetched
    case tasks(params: [String: Any]?)
    // all task lists are fetched, just for showcase to use query on db
    case taskLists(projectID: String, params: [String: Any]?)
    // not implemented in app, just used for testing
    case tasksEdit(method: Moya.Method, taskListID: Int, params: [String: Any])
    // all projects are fetched, just for showcase to use query on db
    case projects(params: [String: Any]?)
    // current user which credentials are hardcoded
    case user
}

extension Service: TargetType {

    // access token used as user name
    static let username = "twp_TEbBXGCnvl2HfvXWfkLUlzx92e3T"
    // password can be anything
    static let password = "test"

    var sampleData: Data {
        return Data()
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
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
        case .taskLists(projectID: let ID, params: _):
            return "/projects/\(ID)/tasklists.json"
        }
    }

    var method: Moya.Method {
        switch self {
        case .tasksEdit(method: let method, taskListID: _, params: _):
            return method
        default:
            return Moya.Method.get
        }
    }

    var task: Task {
        switch self {
        case .tasks(params: let params):
            let parameters = params ?? [:]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .projects(params: let params):
            let parameters = params ?? [:]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .tasksEdit(method: _, taskListID: _, params: let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .user:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case .taskLists(projectID: _, params: let params):
            let parameters = params ?? [:]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

} 


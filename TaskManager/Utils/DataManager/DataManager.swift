//
//  DataManager.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

typealias ErrorBlock = ((ServiceError?) -> Void)

// used for wrapping consecutive requests
class DataManager {

    static let shared = DataManager()

    private init() {}

    static func fetchStartData(completion: @escaping  ErrorBlock) {

        DispatchQueue.global().async {
            var user: User?
            var responseError: ServiceError?

            let group = DispatchGroup()
            group.enter()

            API.request(target: Service.user, object: Wrapper<User>.self) { (result) in
                switch result {
                case .success(let wrapper):
                    print("Success")
                    user = wrapper.object
                case .failure(let error):
                    responseError = error
                }
                group.leave()
            }

            var projects: [Project] = []
            group.enter()
            API.request(target: Service.projects(params: ["status": ProjectStatus.active.rawValue]), object: Wrapper<Project>.self) { (result) in
                switch result {
                case .success(let wrapper):
                    print("Success")
                    projects = wrapper.items
                case .failure(let error):
                    responseError = error
                }
                group.leave()
            }

            var taskLists: [TaskList] = []
            group.enter()
            API.request(target: Service.taskLists(projectID: nil), object: Wrapper<TaskList>.self) { (result) in
                switch result {
                case .success(let wrapper):
                    print("Success")
                    taskLists = wrapper.items
                case .failure(let error):
                    responseError = error
                }
                group.leave()
            }

            group.wait()

            guard let currentUser = user,
                responseError == nil else {
                let er: ServiceError = responseError ?? .noObject
                completion(er)
                return
            }

            group.enter()

            DBManager.shared.addObjects(objects: [currentUser], completion: { (error) in
                group.leave()
            })

            group.enter()
            DBManager.shared.addObjects(objects: projects, completion: { (error) in
                group.leave()
            })

            group.enter()
            DBManager.shared.addObjects(objects: taskLists, completion: { (error) in
                group.leave()
            })


            group.wait()
            completion(nil)

        }

    }

}

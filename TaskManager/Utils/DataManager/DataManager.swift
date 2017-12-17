//
//  DataManager.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import RealmSwift

typealias ErrorBlock = ((ServiceError?) -> Void)?

// used for wrapping consecutive requests
class DataManager {

    static let shared = DataManager()

    private init() {}

    // prefetching data on app launch
    // this is just a showcase, API has pagination there is no need for this 
    // for simplicity of the app pagination and other params are removed from apps logic
    static func fetchStartData(completion: ErrorBlock) {

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
            API.request(target: Service.projects(params: nil), object: Wrapper<Project>.self) { (result) in
                switch result {
                case .success(let wrapper):
                    print("Success")
                    projects = wrapper.items
                case .failure(let error):
                    responseError = error
                }
                group.leave()
            }

            var tasks: [TaskItem] = []
            var hasResponse = true
            group.enter()

            let tasksGroup = DispatchGroup()

            var page = 1
            while hasResponse {
                tasksGroup.enter()
                API.request(target: Service.tasks(params: ["page": page]), object: Wrapper<TaskItem>.self) { (result) in
                    switch result {
                    case .success(let wrapper):
                        print("Success")
                        if wrapper.items.count > 0 {
                            tasks.append(contentsOf: wrapper.items)
                            page += 1
                            tasksGroup.leave()

                        } else {
                            hasResponse = false
                            tasksGroup.leave()
                            group.leave()

                        }

                    case .failure(let error):
                        tasksGroup.leave()
                        responseError = error
                    }
                }
                tasksGroup.wait()
            }

            group.wait()

            var taskLists: [TaskList] = []

            for project in projects {
                group.enter()
                API.request(target: Service.taskLists(projectID: project.id, params: nil), object: Wrapper<TaskList>.self) { (result) in
                    switch result {
                    case .success(let wrapper):
                        print("Success")
                        taskLists.append(contentsOf: wrapper.items)
                    case .failure(let error):
                        responseError = error
                    }
                    group.leave()
                }
            }

            if projects.count > 0 {
                group.wait()
            }

            guard let currentUser = user,
                responseError == nil else {
                let er: ServiceError = responseError ?? .noObject
                completion?(er)
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

            group.enter()
            DBManager.shared.addObjects(objects: tasks, completion: { (error) in
                group.leave()
            })


            group.wait()
            completion?(nil)

        }

    }

    // fetch data from network and refreshing db with that data
    // called on pull to refresh
    static func refreshData<T:DataObject>(target: Service, object:T.Type,_  completion: ErrorBlock) {

        DispatchQueue.global().async {
            let group = DispatchGroup()
            group.enter()

            var fetchedItems: [T] = []
            API.request(target: target, object: Wrapper<T>.self) { (result) in

                switch result {
                case .success(let wrapper):
                    fetchedItems = wrapper.items
                    group.leave()
                case .failure(let error):
                    completion?(error)
                }
            }

            group.wait()

            DBManager.shared.addObjects(objects: fetchedItems) { (error) in
                if let er = error {
                    completion?(er)
                } else {
                    completion?(nil)
                }
            }
        }

    }


}

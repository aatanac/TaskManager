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
    // this is just a showcase, API has pagination
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

            var tasks: [TaskItem] = []
            group.enter()
            API.request(target: Service.tasks(params: nil), object: Wrapper<TaskItem>.self) { (result) in
                switch result {
                case .success(let wrapper):
                    print("Success")
                    tasks = wrapper.items
                case .failure(let error):
                    responseError = error
                }
                group.leave()
            }

            group.wait()

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

    static func refreshData<T:DataObject>(target: Service, object:T.Type,_  completion: ((Result<[T], ServiceError>) -> Void)?) {

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
                    completion?(.failure(error))
                }
            }

            group.wait()
            completion?(.success(fetchedItems))
//
//            var dbItems: [T] = []
//            fetchedItems.forEach({ (item) in
//                dbItems.append(item)
//            })
//
//            group.enter()
//            DBManager.shared.addObjects(objects: dbItems) { (error) in
//                if let er = error {
//                    completion?(.failure(er))
//                } else {
//                    completion?(.success(fetchedItems))
//                }
//            }

        }


    }


}

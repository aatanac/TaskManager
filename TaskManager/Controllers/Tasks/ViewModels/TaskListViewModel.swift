//
//  TaskListViewModel.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import RealmSwift

final class TaskListViewModel: NSObject, ViewModel {

    var token: NotificationToken?
    
    lazy var service: Service = {
        return Service.taskLists(projectID: self.project.id, params: nil)
    }()

    var project: Project

    init(project: Project) {
        self.project = project
        // project ID for query
        self.items = DBManager.shared.fetchObjects(objects: ItemType.self, query: "projectId = '\(self.project.id)'")
    }

    typealias ItemType = TaskList

    var onReloadData: (() -> Void)?

    internal var items: Results<ItemType>

    deinit {
        print("Deinit: ", self)
    }

}

extension TaskListViewModel: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        print("change data")
    }

}

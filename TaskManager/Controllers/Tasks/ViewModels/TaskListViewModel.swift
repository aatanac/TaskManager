//
//  TaskListViewModel.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

final class TaskListViewModel: NSObject, ViewModel {

    var service: Service = Service.taskLists(projectID: nil)
    var project: Project

    init(project: Project) {
        self.project = project
    }

    typealias ItemType = TaskList

    var onReloadData: (() -> Void)?

    internal var items: [ItemType] = [] {
        didSet {
            self.onReloadData?()
        }
    }

}

extension TaskListViewModel: UISearchResultsUpdating{

    func updateSearchResults(for searchController: UISearchController) {
        print("change data")
    }

}

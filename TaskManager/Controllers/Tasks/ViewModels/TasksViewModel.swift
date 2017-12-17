//
//  TasksViewModel.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

final class TasksViewModel: NSObject, ViewModel {

    var token: NotificationToken?

    var service: Service = Service.tasks(params: nil)

    typealias ItemType = TaskItem

    var onReloadData: (() -> Void)?

    internal var items: Results<ItemType> = {
        return DBManager.shared.fetchObjects(objects: ItemType.self, query: nil)
    }()

    deinit {
        print("Deinit: ", self)
    }

}

extension TasksViewModel: UISearchResultsUpdating{

    func updateSearchResults(for searchController: UISearchController) {
        print("change data")
    }

}

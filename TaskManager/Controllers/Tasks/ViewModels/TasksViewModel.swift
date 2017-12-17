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

    var list: TaskList?

    typealias ItemType = TaskItem

    var onReloadData: (() -> Void)?

    init(list: TaskList?) {
        self.list = list
        if let listValue = list,
            let intID = Int(listValue.id) {
            self.items = DBManager.shared.fetchObjects(objects: ItemType.self, query: "todoListId = \(intID)")
        } else {
            self.items = DBManager.shared.fetchObjects(objects: ItemType.self, query: nil)
        }
        super.init()
    }

    var items: Results<ItemType>

    deinit {
        print("Deinit: ", self)
    }

}

extension TasksViewModel: UISearchResultsUpdating{

    func updateSearchResults(for searchController: UISearchController) {
        print("change data")
    }

}

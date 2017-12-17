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

    var listID: Int? {
        if let listValue = list,
            let intID = Int(listValue.id) {
            return intID
        }
        return nil
    }

    typealias ItemType = TaskItem

    var onReloadData: (() -> Void)?

    init(list: TaskList?) {
        self.list = list
        if let listValue = list,
            let intID = Int(listValue.id) {
            self.items = DBManager.shared.fetchObjects(objects: ItemType.self, query: "todoListId = \(intID)", sort: "content")
        } else {
            self.items = DBManager.shared.fetchObjects(objects: ItemType.self, sort: "content")
        }
        super.init()
    }

    var items: Results<ItemType>

    deinit {
        print("Deinit: ", self)
    }

}

extension TasksViewModel: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        print("change data")
        self.handleSearch(for: searchController.searchBar.text )
    }

}

extension TasksViewModel {

    func handleSearch(for searchText: String?) {
        guard let text = searchText else {
            return
        }

        if text == "" {
            if let id = self.listID {
                self.items = DBManager.shared.fetchObjects(objects: ItemType.self, query: "todoListId = \(id)", sort: "content")
            } else {
                self.items = DBManager.shared.fetchObjects(objects: ItemType.self, sort: "content")
            }
        } else {
            if let id = self.listID {
                self.items = DBManager.shared.fetchObjects(objects: ItemType.self, query: "todoListId = \(id) && content CONTAINS[c] '\(text)'", sort: "content")
            } else {
                self.items = DBManager.shared.fetchObjects(objects: ItemType.self, query: "content CONTAINS[c] '\(text)'", sort: "content")
            }
        }
        self.onReloadData?()
    }

}

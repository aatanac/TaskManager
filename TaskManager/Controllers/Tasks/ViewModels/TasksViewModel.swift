//
//  TasksViewModel.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import UIKit

final class TasksViewModel: NSObject, ViewModel {

    var service: Service = Service.tasks

    typealias ItemType = TaskItem

    var onReloadData: (() -> Void)?

    internal var items: [TaskItem] = [] {
        didSet {
            self.onReloadData?()
        }
    }

}

extension TasksViewModel: UISearchResultsUpdating{

    func updateSearchResults(for searchController: UISearchController) {
        print("change data")
    }

}

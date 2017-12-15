//
//  TasksViewModel.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import UIKit

final class TasksViewModel: NSObject {

    typealias TaksBlock = ((ServiceError?) -> Void)

    private var tasks: [TaskItem] = [] {
        didSet {
            self.onReloadData?()
        }
    }

    var onReloadData: (() -> Void)?

    var numberOfRows: Int {
        return self.tasks.count
    }

    func refreshData(completion: @escaping TaksBlock) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        API.request(target: Service.tasks, object: Wrapper<TaskItem>.self) { [weak self] (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false

            switch result {
            case .success(let wrapper):
                self?.tasks = wrapper.items
            case .failure(let error):
                completion(error)
            }
        }

    }

    func item(for indexPath: IndexPath) -> TaskItem {
        let item = self.tasks[indexPath.row]
        return item
    }

}

extension TasksViewModel: UISearchResultsUpdating{

    func updateSearchResults(for searchController: UISearchController) {
        print("change data")
    }

}

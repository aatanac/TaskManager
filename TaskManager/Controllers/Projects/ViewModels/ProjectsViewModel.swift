//
//  ProjectsViewModel.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import RealmSwift

final class ProjectsViewModel: NSObject, ViewModel {
    
    var token: NotificationToken?

    var service: Service = Service.projects(params: nil)

    typealias ItemType = Project

    var onReloadData: (() -> Void)?

    internal var items: Results<ItemType> = {
        return DBManager.shared.fetchObjects(objects: ItemType.self, query: nil)

    }()
    
    deinit {
        print("Deinit: ", self)
    }

}

extension ProjectsViewModel: UISearchResultsUpdating{

    func updateSearchResults(for searchController: UISearchController) {
        print("change data")
    }

}

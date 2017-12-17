//
//  ProjectsViewModel.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

final class ProjectsViewModel: NSObject, ViewModel {

    var service: Service = Service.projects(params: ["status": ProjectStatus.active.rawValue])

    typealias ItemType = Project

    var onReloadData: (() -> Void)?

    internal var items: [ItemType] = [] {
        didSet {
            self.onReloadData?()
        }
    }

}

extension ProjectsViewModel: UISearchResultsUpdating{

    func updateSearchResults(for searchController: UISearchController) {
        print("change data")
    }

}

//
//  ViewModel.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import RealmSwift

typealias DataObject = Object & Codable

// resused for Tasks and Projects
protocol ViewModel: class {

    associatedtype ItemType: DataObject
    var service: Service { get set }
    var items: [ItemType] { get set }
    var onReloadData: (() -> Void)? { get set }
    func refreshData(completion: ErrorBlock)
    func item(for indexPath: IndexPath) -> ItemType

}

// used for all list vieModels
extension ViewModel {

    var numberOfRows: Int {
        return self.items.count
    }

    func item(for indexPath: IndexPath) -> ItemType {
        let item = self.items[indexPath.row]
        return item
    }

    func refreshData(completion: ErrorBlock) {

        DataManager.refreshData(target: self.service, object: ItemType.self) { [weak self] (result) in

            DispatchQueue.main.async {

                switch result {
                case .success(let dbItems):
                    self?.items = dbItems
                    completion?(nil)
                case .failure(let error):
                    completion?(error)
                }
            }

        }

    }

    func fetchFromDB(query: String?, completion: @escaping ((Result<[ItemType], Service>) -> Void)) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        DBManager.shared.fetchObjects(objects: ItemType.self, query: query) { [weak self] (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false

            switch result {
            case .success(let dbItems):
                self?.items = dbItems
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

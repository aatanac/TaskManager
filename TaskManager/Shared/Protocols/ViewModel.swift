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

// resused for Tasks, Projects and tasksList
protocol ViewModel: class {

    // object type
    associatedtype ItemType: DataObject
    // init service for network request (refresh data)
    var service: Service { get set }
    // db items
    var items: Results<ItemType> { get set }
    // called on refresh data
    var onReloadData: (() -> Void)? { get set }
    // pull to refresh action
    func refreshData(completion: ErrorBlock)
    // passing item to vc list
    func item(for indexPath: IndexPath) -> ItemType
    // object for listening changes in db
    // with timeStamp works perfectly
    var token: NotificationToken? { get set }

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
        DataManager.refreshData(target: self.service, object: ItemType.self) { (error) in
            DispatchQueue.main.async {
                if let er = error {
                    print(er.localizedDescription)
                } else {
                    print("Success")
                }
                completion?(error)
            }
        }

    }

    // called in vc that listens changes on db, has pull to refresh implemented
    func subscribeToDBNotification() {
        self.token = self.items.observe { [weak self] (changes: RealmCollectionChange) in
            self?.onReloadData?()
        }
    }

}

//
//  ViewModel.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

typealias ErrorBlock = ((ServiceError?) -> Void)

// resused for Tasks and Projects
protocol ViewModel: class {

    associatedtype ItemType: Codable
    var service: Service { get set }
    var items: [ItemType] { get set }
    var onReloadData: (() -> Void)? { get set }
    func refreshData(completion: @escaping ErrorBlock)
    func item(for indexPath: IndexPath) -> ItemType

}

extension ViewModel {

    var numberOfRows: Int {
        return self.items.count
    }

    func item(for indexPath: IndexPath) -> ItemType {
        let item = self.items[indexPath.row]
        return item
    }

    func refreshData(completion: @escaping ErrorBlock) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        API.request(target: self.service, object: Wrapper<ItemType>.self) { [weak self] (result) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false

            switch result {
            case .success(let wrapper):
                self?.items = wrapper.items
            case .failure(let error):
                completion(error)
            }
        }

    }

}

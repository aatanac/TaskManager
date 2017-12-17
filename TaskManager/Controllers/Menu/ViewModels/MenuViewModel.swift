//
//  MenuViewModel.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

class MenuViewModel {

    var type: MenuType
    private var items: [MenuItem]

    init(type: MenuType) {
        self.type = type
        self.items = type.items
    }
    var numberOfItems: Int {
        return self.items.count
    }

    func item(for indexPath: IndexPath) -> MenuItem {
        let item = self.items[indexPath.row]
        return item
    }

}

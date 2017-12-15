//
//  MenuViewModel.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

class MenuViewModel {

    private let items: [MenuItem] = [.dashboard, .project, .latestActivity, .shortcuts, .tasks, .messages, .milestones, .statuses, .people, .events, .loggedTime]

    var numberOfItems: Int {
        return self.items.count
    }

    func item(for indexPath: IndexPath) -> MenuItem {
        let item = self.items[indexPath.row]
        return item
    }

}

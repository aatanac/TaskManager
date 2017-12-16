//
//  Wrapper.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

// reused for different objects that are wrapped with different keys
struct Wrapper<T: Codable>: Codable {
    var items: [T]

    enum ItemKeys: String, CodingKey {
        case items = "todo-items"
    }

    enum ProjectKeys: String, CodingKey {
        case projects
    }

    init(items: [T]) {
        self.items = items
    }

    init(from decoder: Decoder) throws {
        var items: [T] = []

        switch T.self {
        case is TaskItem.Type:
            let container = try decoder.container(keyedBy: ItemKeys.self)
            items = try container.decode([T].self, forKey: .items)
        case is Project.Type:
            let container = try decoder.container(keyedBy: ProjectKeys.self)
            items = try container.decode([T].self, forKey: .projects)
        default:
            assertionFailure("please check coding keys :)")
        }

        self.init(items: items)
    }
}

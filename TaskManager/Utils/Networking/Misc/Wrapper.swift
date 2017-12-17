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
    var object: T?

    // used for parsing taskLists and tasks
    enum ItemKey: String, CodingKey {
        case items = "todo-items"
    }

    enum ProjectKey: String, CodingKey {
        case projects
    }

    enum UserKey: String, CodingKey {
        case person
    }

    enum TaskListKey: String, CodingKey {
        case tasklists
    }

    init(items: [T], object: T?) {
        self.items = items
        self.object = object
    }

    init(from decoder: Decoder) throws {
        var items: [T] = []
        var object: T?

        switch T.self {
        case is TaskItem.Type:
            let container = try decoder.container(keyedBy: ItemKey.self)
            items = try container.decode([T].self, forKey: .items)

        case is Project.Type:
            let container = try decoder.container(keyedBy: ProjectKey.self)
            items = try container.decode([T].self, forKey: .projects)

        case is User.Type:
            let container = try decoder.container(keyedBy: UserKey.self)
            object = try container.decode(T.self, forKey: .person)

        case is TaskList.Type:
            let container = try decoder.container(keyedBy: TaskListKey.self)
            items = try container.decode([T].self, forKey: .tasklists)

        default:
            assertionFailure("please check coding keys :)")
        }

        self.init(items: items, object: object)
    }
}

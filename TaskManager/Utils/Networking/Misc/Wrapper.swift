//
//  Wrapper.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

struct Wrapper<T: Codable>: Codable {
    var items: [T]

    enum CodingKeys: String, CodingKey {
        case items = "todo-items"
    }

    init(items: [T]) {
        self.items = items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if T.self == TaskItem.Type.self {

        }
        let items: [T] = try container.decode([T].self, forKey: .items)
        self.init(items: items)
    }
}

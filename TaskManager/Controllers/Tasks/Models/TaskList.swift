//
//  TaskList.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import RealmSwift

class TaskList: Object, Codable {

    @objc dynamic var id: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var projectId: String = ""
    @objc dynamic var count: Int = 0

    enum CodingKeys: String, CodingKey {
        case id
        case desc = "description"
        case name
        case projectId
        case count = "uncompleted-count"
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.desc = try values.decode(String.self, forKey: .desc)
        self.name = try values.decode(String.self, forKey: .name)
        self.count = try values.decode(Int.self, forKey: .count)
        self.projectId = try values.decode(String.self, forKey: .projectId)

        if self.desc == "" {
            // used from app
            self.desc = "No description"
        }
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    override static func indexedProperties() -> [String] {
        return ["id"]
    }

}

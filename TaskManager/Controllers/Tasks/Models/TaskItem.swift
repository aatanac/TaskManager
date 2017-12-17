//
//  Task.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/13/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class TaskItem: Object, Codable {

    @objc dynamic var id: Int = 0
    @objc dynamic var canComplete: Bool = false
    @objc dynamic var commentsCount: Int = 0
    @objc dynamic var desc: String = ""
    @objc dynamic var hasReminders: Bool = false
    @objc dynamic var hasUnreadComments: Bool = false
    @objc dynamic var isPrivate: Int = 0
    @objc dynamic var content: String = ""
    @objc dynamic var order: Int = 0
    @objc dynamic var projectId: Int = 0
    @objc dynamic var projectName: String = ""
    @objc dynamic var todoListId: Int = 0
    @objc dynamic var todoListName: String?
    @objc dynamic var status: String = ""
    @objc dynamic var canEdit: Bool = false
    @objc dynamic var createdOn: Date?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case canComplete = "canComplete"
        case commentsCount = "comments-count"
        case desc = "description"
        case hasReminders = "has-reminders"
        case hasUnreadComments = "has-unread-comments"
        case isPrivate = "private"
        case content = "content"
        case order = "order"
        case projectId = "project-id"
        case projectName = "project-name"
        case todoListId = "todo-list-id"
        case todoListName = "todo-list-name"
        case status
        case canEdit
        case createdOn = "created-on"

    }

    override static func primaryKey() -> String? {
        return "id"
    }

    override static func indexedProperties() -> [String] {
        return ["id"]
    }

}

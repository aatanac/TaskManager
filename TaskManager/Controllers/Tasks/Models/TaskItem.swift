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

    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.canComplete = try values.decode(Bool.self, forKey: .canComplete)
        self.commentsCount = try values.decode(Int.self, forKey: .commentsCount)
        self.desc = try values.decode(String.self, forKey: .desc)
        self.hasReminders = try values.decode(Bool.self, forKey: .hasReminders)
        self.hasUnreadComments = try values.decode(Bool.self, forKey: .hasUnreadComments)
        self.isPrivate = try values.decode(Int.self, forKey: .isPrivate)
        self.content = try values.decode(String.self, forKey: .content)
        self.order = try values.decode(Int.self, forKey: .order)
        self.projectId = try values.decode(Int.self, forKey: .projectId)
        self.projectName = try values.decode(String.self, forKey: .projectName)
        self.todoListId = try values.decode(Int.self, forKey: .todoListId)
        self.todoListName = try values.decode(String.self, forKey: .todoListName)
        self.status = try values.decode(String.self, forKey: .status)
        self.canEdit = try values.decode(Bool.self, forKey: .canEdit)

    }


    override static func primaryKey() -> String? {
        return "id"
    }

}

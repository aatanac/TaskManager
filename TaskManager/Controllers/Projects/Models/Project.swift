//
//  Project.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//
import Foundation
import RealmSwift

class Project: Object, Codable {

	@objc dynamic var company: Company?
	@objc dynamic var starred: Bool = false
	@objc dynamic var name: String = ""
	@objc dynamic var showAnnouncement: Bool = false
	@objc dynamic var announcement: String = ""
	@objc dynamic var desc: String = ""
	@objc dynamic var status: String = ""
	@objc dynamic var isProjectAdmin : Bool = false
	@objc dynamic var createdOn: String = ""
	@objc dynamic var category: Category?
	@objc dynamic var startPage: String = ""
	@objc dynamic var startDate: String = ""
	@objc dynamic var logo: String = ""
	@objc dynamic var notifyeveryone: Bool = false
	@objc dynamic var id: String = ""
	@objc dynamic var lastChangedOn: String = ""
	@objc dynamic var endDate: String = ""
	@objc dynamic var harvestTimersOnabled: Bool = false

	enum CodingKeys: String, CodingKey {

		case company
		case starred = "starred"
		case name = "name"
		case showAnnouncement = "show-announcement"
		case announcement = "announcement"
		case desc = "description"
		case status = "status"
		case isProjectAdmin = "isProjectAdmin"
		case createdOn = "created-on"
		case category
		case startPage = "start-page"
		case startDate = "startDate"
		case logo = "logo"
		case notifyeveryone = "notifyeveryone"
		case id = "id"
		case lastChangedOn = "last-changed-on"
		case endDate = "endDate"
		case harvestTimersOnabled = "harvest-timers-enabled"
	}

    override static func primaryKey() -> String? {
        return "id"
    }

    override static func indexedProperties() -> [String] {
        return ["id"]
    }

}

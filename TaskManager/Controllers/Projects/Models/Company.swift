//
//  Company.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import RealmSwift

class Company: Object, Codable {
	@objc dynamic var name : String = ""
	@objc dynamic var isOwner : String?
	@objc dynamic var id : String = ""

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case isOwner = "is-owner"
		case id = "id"
	}

    override static func primaryKey() -> String? {
        return "id"
    }

}

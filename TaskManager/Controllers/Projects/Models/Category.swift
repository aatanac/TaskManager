//
//  Category.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object, Codable {
	@objc dynamic var name : String = ""
	@objc dynamic var id : String = ""

	enum CodingKeys: String, CodingKey {
		case name = "name"
		case id = "id"
	}

    convenience required init(from decoder: Decoder) throws {
        self.init()
		let values = try decoder.container(keyedBy: CodingKeys.self)
		self.name = try values.decode(String.self, forKey: .name)
		self.id = try values.decode(String.self, forKey: .id)
	}

    override static func primaryKey() -> String? {
        return "id"
    }

}

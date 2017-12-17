//
//  User.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/16/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object, Codable {

    @objc dynamic var id: String = ""
    @objc dynamic var userName: String = ""
    @objc dynamic var imgUrl: String = "avatar-url"
    @objc dynamic var firstName: String = "first-name"
    @objc dynamic var lastName: String = "last-name"
    @objc dynamic var email: String = "email-address"


    enum CodingKeys: String, CodingKey {

        case id = "id"
        case userName = "user-name"
        case imgUrl = "avatar-url"
        case firstName = "first-name"
        case lastName = "last-name"
        case email = "email-address"

    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.userName = try values.decode(String.self, forKey: .userName)
        self.imgUrl = try values.decode(String.self, forKey: .imgUrl)
        self.firstName = try values.decode(String.self, forKey: .imgUrl)
        self.lastName = try values.decode(String.self, forKey: .imgUrl)
        self.email = try values.decode(String.self, forKey: .imgUrl)
    }

    override static func primaryKey() -> String? {
        return "id"
    }

}

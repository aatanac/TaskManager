//
//  UrlObject.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/18/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

import Foundation
import RealmSwift

class UrlObject: Object, Codable {

    static let defaultTimestamp = "20011212050000"

    @objc dynamic var urlString : String = ""
    @objc dynamic var timestamp : String = ""

    override static func primaryKey() -> String? {
        return "urlString"
    }

    override static func indexedProperties() -> [String] {
        return ["urlString"]
    }

}

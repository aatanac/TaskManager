//
//  ThemeObject.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import RealmSwift

// simple object that is preserving int value of hc value
// just for simple use in this app
class ThemeObject: Object, Codable {

    @objc dynamic var id: String = "0"// hc value
    @objc dynamic var color: Int = 0 // hc value

    override static func primaryKey() -> String? {
        return "id"
    }

}

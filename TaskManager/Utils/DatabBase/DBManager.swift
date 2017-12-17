//
//  DBManager.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {

    static let shared = DBManager()

    private init() {}

    let realmQueue = "RealmQueue"

    // start configuration for db
    // usesd default on because of simplicity of app
    // if there were multiple accounts every use would have own db
    static func configure() {
        let config = Realm.Configuration()
        Realm.Configuration.defaultConfiguration = config
        print(config.fileURL ?? "No url!!!")
    }

    // add/update objects fetched from network call
    func addObjects(objects: [Object], completion: ErrorBlock) {
        guard objects.count > 0 else {
            completion?(nil)
            return
        }

        DispatchQueue(label: self.realmQueue).async {
            autoreleasepool {
                let realm = try! Realm()
                try! realm.write {
                    realm.add(objects, update: true)
                } 
                completion?(nil)
            }
        }
    }

    // fetch single object
    func fetchObject<T: DataObject>(objects: T.Type, query: String? = nil) -> T? {
        let realm = try! Realm()
        var result = realm.objects(T.self)
        if let queryString = query {
            result = result.filter(queryString)
        }

        return result.first
    }

    // fetch multiple objects
    func fetchObjects<T: DataObject>(objects: T.Type, query: String? = nil, sort: String? = nil) -> Results<T> {
        let realm = try! Realm()
        var result = realm.objects(T.self)
        if let queryString = query {
            result = result.filter(queryString)
        }
        if let sortString = sort {
            result = result.sorted(byKeyPath: sortString, ascending: true)
        }

        return result
    }

}

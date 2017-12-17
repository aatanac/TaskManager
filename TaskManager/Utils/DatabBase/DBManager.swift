//
//  DBManager.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import RealmSwift


typealias DBBlock = ((Result<Object, Service>) -> Void)

class DBManager {

    static let shared = DBManager()

    private init() {}

    let realmQueue = "RealmQueue"

    static func configure() {
        let config = Realm.Configuration()
        Realm.Configuration.defaultConfiguration = config
        print(config.fileURL ?? "No url!!!")
    }

    func addObjects(objects: [Object], completion: @escaping ErrorBlock) {

        guard objects.count > 0 else {
            completion(nil)
            return
        }

        DispatchQueue(label: self.realmQueue).async {
            autoreleasepool {
                let realm = try! Realm()
                try! realm.write {
                    realm.add(objects, update: true)
                }
            }
            completion(nil)
        }
    }

    func getObjects<T: Object>(objects: T, query: String, completion: @escaping ((Result<Results<T>, Service>) -> Void)) {

        let realm = try! Realm()
        let result = realm.objects(T.self).filter(query)

        completion(.success(result))

    }

}

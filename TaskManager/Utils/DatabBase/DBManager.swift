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

    func fetchObjects<T: Object>(objects: T, query: String, completion: @escaping ((Result<[T], Service>) -> Void)) {

        let realm = try! Realm()
        let result = realm.objects(T.self).filter(query)
        let array: [T] = result.flatMap{$0}
        
        completion(.success(array))

    }

}

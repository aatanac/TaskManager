//
//  UrlManager.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/18/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import RealmSwift

final class UrlManager {

    private static let shared = UrlManager()

    internal var items: Results<UrlObject> = {
        let result = DBManager.shared.fetchObjects(objects: UrlObject.self)
        return result
    }()

    private var urls: [String: String] = [:]

    var token: NotificationToken?

    private init() {}

    // called in vc that listens changes on db, has pull to refresh implemented
    private func subscribeToDBNotification() {
        self.token = self.items.observe { [weak self] (changes: RealmCollectionChange) in
            // filling dict to prevent accessing realm object in other thread
            self?.urls.removeAll()
            self?.items.forEach({ (urlObject) in
                self?.urls[urlObject.urlString] = urlObject.timestamp
            })
            print("Saved objec, count is: ", self?.urls.count ?? "no items")

        }
    }
    // must be called for calling first init and subscribing to db notifications
    // in appdelegate
    static func configure() {
        UrlManager.shared.subscribeToDBNotification()
        UrlManager.shared.items.forEach({ (urlObject) in
            UrlManager.shared.urls[urlObject.urlString] = urlObject.timestamp
        })
    }

    // saving url object responsibility of this class
    static func saveObject(object: UrlObject) {
        DBManager.shared.addObjects(objects: [object], completion: nil)
    }

    // if there is no object returning timestamp that will return all values
    static func fetchTimeStamp(for urlString: String) -> String {
        let results = UrlManager.shared.urls[urlString]
        if let first = results {
            return first
        }
        return UrlObject.defaultTimestamp
    }

    static func createObject(urlString: String?) -> UrlObject? {
        guard let url = urlString else {
            return nil
        }
        let urlObject = UrlObject()
        urlObject.urlString = url
        urlObject.timestamp = DateManager.dateString(from: Date(), format: .timeStamp)
        return urlObject
    }

}

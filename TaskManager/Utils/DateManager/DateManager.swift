//
//  DateManager.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

class DateManager {

    static let shared = DateManager()
    private var formatterDecoding: DateFormatter
    private var formatterInApp: DateFormatter

    private static let dateDecodingFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    private static let dateShowingFormat = "E dd MMM yyyy"

    private init() {
        self.formatterDecoding = DateFormatter()
        self.formatterDecoding.dateFormat = DateManager.dateDecodingFormat

        self.formatterInApp = DateFormatter()
        self.formatterInApp.dateFormat = DateManager.dateShowingFormat
    }

    static var formatter: DateFormatter {
        return DateManager.shared.formatterDecoding
    }

    static func dateString(from date: Date) -> String {
        return DateManager.shared.formatterInApp.string(from: date)
    }

}

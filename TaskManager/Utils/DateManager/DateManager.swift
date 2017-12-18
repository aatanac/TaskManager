//
//  DateManager.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

class DateManager {

    enum DateFormat: String {
        case dateDecoding = "yyyy-MM-dd'T'HH:mm:ssZ" // decoding from response
        case dateShow = "E dd MMM yyyy"              // date in aps
        case timeStamp = "YYYYMMddHHmmss"            // timestamp for url saving
    }

    static let shared = DateManager()
    private var formatterDecoding: DateFormatter
    private var formatterInApp: DateFormatter

    private init() {
        self.formatterDecoding = DateFormatter()
        self.formatterDecoding.dateFormat = DateFormat.dateDecoding.rawValue

        self.formatterInApp = DateFormatter()
        self.formatterInApp.dateFormat = DateFormat.dateShow.rawValue
    }

    static var formatter: DateFormatter {
        return DateManager.shared.formatterDecoding
    }

    static func dateString(from date: Date, format: DateFormat = .dateShow) -> String {
        DateManager.shared.formatterInApp.dateFormat = format.rawValue
        return DateManager.shared.formatterInApp.string(from: date)
    }

}

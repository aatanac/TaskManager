//
//  ServiceError.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/13/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

enum ServiceError: Error, CustomStringConvertible {

    private static let defaultTitle = "Error"

    case error(_: Error)
    case noObject
    case unknown(response: [String: Any]?)

    var title: String {
        switch self {
        case .error(_):
            return ServiceError.defaultTitle
        case .unknown:
            return ServiceError.defaultTitle
        case .noObject:
            return ServiceError.defaultTitle
        }
    }

    var description: String {
        switch self {
        case .error(let error):
            return error.localizedDescription
        case .unknown:
            return "Unknown error"
        case .noObject:
            return "No object. Please check parsing and db saving"
        }
    }

    static func parseError(data: Data) -> ServiceError {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let dict = json as? [String: Any] {
            return .unknown(response: dict)
        } else {
            print("No data")
        }

        return .unknown(response: nil)
    }

}



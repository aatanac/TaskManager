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
    case responseError(data: Data)
    case unknown

    var title: String {
        switch self {
        case .error(_):
            return ServiceError.defaultTitle
        case .responseError(_):
            return ServiceError.defaultTitle
        case .unknown:
            return ServiceError.defaultTitle
        }
    }

    var description: String {
        switch self {
        case .error(let error):
            return error.localizedDescription
        case .responseError(data: _):
            return ""
        case .unknown:
            return "Unknown error"
        }
    }

    static func parseError(data: Data) -> ServiceError {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let dict = json as? [String: Any] {
            print(dict)
        } else {
            print("No data")
        }

        return .unknown
    }

}



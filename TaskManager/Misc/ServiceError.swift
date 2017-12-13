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

    case unknown(error: Error)
    case responseError(data: Data)

    var title: String {
        switch self {
        case .unknown(error: _):
            return ServiceError.defaultTitle
        case .responseError(data: _):
            return ServiceError.defaultTitle
        }
    }

    var description: String {
        switch self {
        case .unknown(error: let error):
            return error.localizedDescription
        case .responseError(data: _):
            return ""
        }
    }

}



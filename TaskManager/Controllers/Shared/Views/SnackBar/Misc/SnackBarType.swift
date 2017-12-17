//
//  SnackBarType.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

enum SnackBarType {
    case message(msg: String)
    case error(error: ServiceError)

    var bgColor: UIColor {
        switch self {
        case .error(error: _):
            return Color.red
        case .message(msg: _):
            return ThemeManager.currentTheme.color
        }
    }

    var message: String {
        switch self {
        case .error(error: let error):
            return error.title + "\n" + error.description
        case .message(msg: let title):
            return title
        }
    }

}

//
//  MenuType.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/16/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

public enum MenuType {
    case menu
    case settings

    var items: [MenuItem] {
        switch self {
        case .menu:
            return [.dashboard, .project, .latestActivity, .shortcuts, .tasks, .messages, .milestones, .statuses, .people, .events, .loggedTime]
        case .settings:
            return [.colorTheme]
        }
    }

    var textAlignment: NSTextAlignment {
        switch self {
        case .menu:
            return .left
        case .settings:
            return .right
        }
    }
}

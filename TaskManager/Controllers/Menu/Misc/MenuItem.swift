//
//  MenuItem.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

public enum MenuItem: String {
    case dashboard = "Dashboard"
    case project = "Project"
    case latestActivity = "Latest Activity"
    case shortcuts = "Shortcuts"
    case tasks = "Tasks"
    case messages = "Messages"
    case milestones = "Mlestones"
    case statuses = "Statuses"
    case people = "People"
    case events = "Events"
    case loggedTime = "Logged Time"

    var title: String {
        return self.rawValue
    }

    var icon: UIImage {
        switch self {
        case .dashboard:
            return UIImage()
        case .project:
            return UIImage()
        case .latestActivity:
            return UIImage()
        case .shortcuts:
            return UIImage()
        case .tasks:
            return UIImage()
        case .messages:
            return UIImage()
        case .milestones:
            return UIImage()
        case .statuses:
            return UIImage()
        case .people:
            return UIImage()
        case .events:
            return UIImage()
        case .loggedTime:
            return UIImage()
        }
    }

}

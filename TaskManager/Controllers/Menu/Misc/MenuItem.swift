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
    case milestones = "Milestones"
    case statuses = "Statuses"
    case people = "People"
    case events = "Events"
    case loggedTime = "Logged Time"
    case colorTheme = "Theme"

    var title: String {
        return self.rawValue
    }

    var icon: UIImage {
        switch self {
        case .dashboard:
            return Image.dashboard.image
        case .project:
            return Image.projects.image
        case .latestActivity:
            return Image.activity.image
        case .shortcuts:
            return Image.shortcut.image
        case .tasks:
            return Image.tasks.image
        case .messages:
            return Image.message.image
        case .milestones:
            return Image.milestone.image
        case .statuses:
            return Image.status.image
        case .people:
            return Image.people.image
        case .events:
            return Image.events.image
        case .loggedTime:
            return Image.loggedTime.image
        case .colorTheme:
            return Image.colorTheme.image
        }
    }

    var vcType: AnyClass {
        switch self {
        case .colorTheme:
            return ColorViewController.self
        case .project:
            return ProjectsViewController.self
        case .tasks:
            return TasksViewController.self
        default:
            return TestViewController.self
        }
    }

}

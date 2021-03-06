//
//  Image.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

public enum Image: String, ImageAsset {
    case menu
    case projects
    case dashboard
    case activity
    case events
    case loggedTime
    case message
    case milestone
    case people
    case shortcut
    case status
    case tasks
    case tick
    case settings
    case colorTheme
    case star
    case checkmark

    var name: String {
        return self.rawValue
    }
}

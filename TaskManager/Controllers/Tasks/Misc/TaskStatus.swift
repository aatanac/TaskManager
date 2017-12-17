//
//  TaskStatus.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

public enum TaskStatus: String {
    case deleted
    case completed
    case reopened
    case new

    var color: UIColor {
        switch self {
        case .completed, .deleted:
            return Color.green
        default:
            return Color.gray
        }
    }

}

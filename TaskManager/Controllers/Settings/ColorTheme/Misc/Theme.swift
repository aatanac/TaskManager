//
//  Theme.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

enum Theme: Int {
    case darkBlue
    case darkGray
    case gray
    case brown
    case kaki
    case lightGreen
    case green
    case blue
    case red
    case yellow
    case pink
    case purple
    case cyan
    case magenta
    case orange

    static let defaultValue = 0

    var color: UIColor {
        switch self {
        case .darkBlue:
            return Color.darkBlue
        case .darkGray:
            return Color.darkGray
        case .gray:
            return Color.gray
        case .brown:
            return Color.brown
        case .kaki:
            return Color.kaki
        case .lightGreen:
            return Color.lightGreen
        case .green:
            return Color.green
        case .blue:
            return Color.blue
        case .red:
            return Color.red
        case .yellow:
            return Color.yellow
        case .pink:
            return Color.pink
        case .purple:
            return Color.purple
        case .cyan:
            return UIColor.cyan
        case .magenta:
            return UIColor.magenta
        case .orange:
            return UIColor.orange
        }
    }

    var barItemsColor: UIColor {
        return .white
    }

}

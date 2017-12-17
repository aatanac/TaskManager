//
//  AppearanceManager.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let apllyTheme = Notification.Name("ApllyTheme")
}

class ThemeManager {

    static let shared = ThemeManager()
    static let themeKey = "ThemeKey"
    private var currentTheme: Theme = .darkBlue

    // configure start theme on app launch
    static func configure() {
        let themeValue = DBManager.shared.fetchObject(objects: ThemeObject.self)
        let theme = Theme(rawValue: themeValue?.color ?? Theme.defaultValue)!
        ThemeManager.shared.currentTheme = theme
        ThemeManager.applyTheme(theme: theme)
    }

    // apply theme on navigation bar and items
    static func applyTheme(theme: Theme) {

        // create and save theme
        let themeObject = ThemeObject()
        themeObject.color = theme.rawValue
        DBManager.shared.addObjects(objects: [themeObject], completion: nil)
        ThemeManager.shared.currentTheme = theme

        let navigationBarAppearace = UINavigationBar.appearance()
        // navBar background color
        navigationBarAppearace.barTintColor = theme.color
        // navBar items tint color
        navigationBarAppearace.tintColor = theme.barItemsColor
        // navBar title color
        navigationBarAppearace.titleTextAttributes = [NSAttributedStringKey.foregroundColor: theme.barItemsColor, NSAttributedStringKey.font: Font.OpenSans.bold.font(size: 16)]
        // searchBar text color
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: theme.barItemsColor]
        // searchBar items color
        UISearchBar.appearance().tintColor = theme.barItemsColor
        // reloading UI depenging on theme
        NotificationCenter.default.post(name: Notification.Name.apllyTheme, object: nil)
    }

    // wrapping singletone property
    static var currentTheme: Theme {
        return ThemeManager.shared.currentTheme
    }


}

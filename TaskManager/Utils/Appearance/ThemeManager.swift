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

    static let themeKey = "ThemeKey"

    // configure start theme on app launch
    static func configure() {
        let theme = ThemeManager.currentTheme()
        ThemeManager.applyTheme(theme: theme)
    }

    // apply theme on navigation bar and items
    static func applyTheme(theme: Theme) {
        UserDefaults.standard.setValue(theme.rawValue, forKey: themeKey)
        UserDefaults.standard.synchronize()

        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor = theme.color
        navigationBarAppearace.tintColor = theme.barItemsColor
        navigationBarAppearace.titleTextAttributes = [NSAttributedStringKey.foregroundColor: theme.barItemsColor, NSAttributedStringKey.font: Font.OpenSans.bold.font(size: 16)]

        NotificationCenter.default.post(name: Notification.Name.apllyTheme, object: nil)
    }

    // saved theme to userdefaults
    static func currentTheme() -> Theme {
        let storedTheme = UserDefaults.standard.integer(forKey: themeKey)
        if let theme = Theme(rawValue: storedTheme) {
            return theme
        } else {
            return Theme.defaultTheme
        }
    }   

}

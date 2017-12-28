//
//  SWRevealViewController+Extensions.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

extension SWRevealViewController {

    func configure() {
        self.frontViewShadowOpacity = 0
        self.view.backgroundColor = ThemeManager.currentTheme.color
        self.subscribeToNotification()
    }

    func subscribeToNotification() {
        NotificationCenter.default.addObserver(forName: Notification.Name.apllyTheme, object: nil, queue: .main) { [weak self] (_) in
            let theme = ThemeManager.currentTheme
            self?.view.backgroundColor = theme.color
        }
    }

}

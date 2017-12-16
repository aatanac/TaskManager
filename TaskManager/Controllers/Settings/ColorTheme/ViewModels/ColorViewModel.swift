//
//  ColorViewModel.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

class ColorViewModel {

    private let items: [Theme] = [.darkBlue, .darkGray, .gray, .brown, .kaki, .lightGreen, .green, .blue, .red, .yellow, .pink, .purple, .cyan, .orange, .magenta]

    var numberOfItems: Int {
        return self.items.count
    }

    func item(for indexPath: IndexPath) -> Theme {
        let item = self.items[indexPath.row]
        return item
    }

    func applyTheme(_ theme: Theme) {
        ThemeManager.applyTheme(theme: theme)
    }

}

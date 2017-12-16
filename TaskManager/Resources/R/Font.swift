//
//  Font.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

public struct Font {

    enum OpenSans: String, FontAsset {
        case bold = "OpenSans-Bold"
        case boldItalic = "OpenSans-BoldItalic"
        case extraBold = "OpenSans-ExtraBold"
        case extraBoldItalic = "OpenSans-ExtraBoldItalic"
        case italic = "OpenSans-Italic"
        case light = "OpenSans-Light"
        case lightItalic = "OpenSans-LightItalic"
        case regular = "OpenSans-Regular"
        case semiBold = "OpenSans-SemiBold"
        case semiBoldItalic = "OpenSans-SemiBoldItalic"

        var name: String {
            return self.rawValue
        }
    }
}

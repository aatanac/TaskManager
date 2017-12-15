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

        var name: String {
            return self.rawValue
        }
    }
}

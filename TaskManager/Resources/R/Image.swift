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

    var name: String {
        return self.rawValue
    }
}

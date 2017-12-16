//
//  Asset.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

protocol Asset {
    var name: String { get }
}

/// Used for instantiating fonts.
protocol FontAsset: Asset {
    func font(size: CGFloat) -> UIFont
}

extension FontAsset {
    func font(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: self.name, size: size) else {
            assertionFailure("Cant find font of name: \(self.name)")
            return UIFont.systemFont(ofSize: size)
        }

        return font
    }
}

/// Used for instantiating images.
protocol ImageAsset: Asset {
    var image: UIImage { get }
}

extension ImageAsset {
    var image: UIImage {
        guard let image = UIImage(named: self.name) else {
            assertionFailure("Cant find image named \(self.name)")
            return UIImage()
        }

        return image
    }

    // template image
    var imageTemplate: UIImage {
        return self.image.withRenderingMode(.alwaysTemplate)
    }
}

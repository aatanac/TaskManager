//
//  UIImageView+Kingfisher.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {

    func setImage(with urlString: String?, placeholderImage: UIImage? = nil, completion: ((NSError?) -> Void)? = nil) {

        guard let url = urlString,
            let imageURL = URL(string: url) else {
                self.image = placeholderImage
                completion?(nil)
                return
        }

        let imageResource = ImageResource(downloadURL: imageURL)
        self.kf.setImage(with: imageResource, placeholder: placeholderImage, options: nil, progressBlock: nil) {(image, error, _, _) in
            if image != nil {
                completion?(error)
            } else {
                completion?(nil)
            }
        }
    }


}

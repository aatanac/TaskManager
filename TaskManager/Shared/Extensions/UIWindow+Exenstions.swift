//
//  UIWindow+Exenstions.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

extension UIWindow {

    static var rootVc: UIViewController? {
        guard let appDelagate = UIApplication.shared.delegate as? AppDelegate,
            let root = appDelagate.window?.rootViewController else {
                return nil
        }
        return root
    }

}

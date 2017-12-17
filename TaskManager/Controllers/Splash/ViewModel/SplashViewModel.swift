//
//  SplashViewModel.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/16/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

class SplashViewModel {

    func fetchStartData(completion: ErrorBlock) {

        DataManager.fetchStartData { (error) in
            DispatchQueue.main.async {
                if let er = error {
                    completion?(er)
                } else {
                    completion?(nil)
                }
            }
        }

    }

}

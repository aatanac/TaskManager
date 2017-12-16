//
//  Coordinator.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation

import UIKit

protocol Coordinator: class {

    // The array containing any child Coordinators
    var childCoordinators: [Coordinator] { get set }
    func start()
}

protocol RootCoordinator: Coordinator {

    // every cooordinate must have reference to SwrevealVc
    var revealController: SWRevealViewController! { get }
    var window: UIWindow! { get }
    init(window: UIWindow)
}

protocol ChildCoordinator: Coordinator {
    // child coordinators only have reference to navigation controller
    var navigationController: NavigationController! { get }
    init(navigationController: NavigationController)
}

extension Coordinator {

    // Add a child coordinator to the parent
    public func addChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }

    // Remove a child coordinator from the parent
    public func removeChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }

}

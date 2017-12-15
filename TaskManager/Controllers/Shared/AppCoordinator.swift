//
//  AppCoordinator.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator: RootCoordinator {

    var window: UIWindow
    var revealController: SWRevealViewController!
    var childCoordinators: [Coordinator] = []

    var frontNavigation: NavigationController!

    init(window: UIWindow) {
        self.window = window
        self.configureNavigation()
    }

    // setuping menu and home controller
    func start() {
        let tasksVc = TasksViewController()
        self.frontNavigation = self.wrapWithNavVc(vc: tasksVc)
        let menuVc = MenuViewController()

        tasksVc.onTaskSelected = { [weak self] task in
            self?.showSingleTask(for: task)
        }

        menuVc.onItemSelected = { [weak self] item in
            self?.showVc(for: item)
        }

        self.revealController.rearViewController = self.wrapWithNavVc(vc: menuVc)
        self.revealController.frontViewController = self.frontNavigation
    }

    // setup reveal controller as root vc of app
    private func configureNavigation() {
        self.revealController = SWRevealViewController()
        self.revealController.configure()
        self.window.rootViewController = self.revealController
    }

    private func showVc(for item: MenuItem) {
        switch item {
        case .dashboard:
            print("dashboard")
        default:
            print("controller: ", item.title)
        }

    }

    private func showSingleTask(for item: TaskItem) {
        let vc = SingleTaskViewController(task: item)
        self.frontNavigation.pushViewController(vc, animated: true)
    }

    // shorthand method for avoid repeatition of code when vc is pushed
    private func wrapWithNavVc(vc: UIViewController) -> NavigationController {
        let navigationController = NavigationController()
        navigationController.viewControllers = [vc]
        // to avoid configuring menu controllers gestures in controller setup is moved here
        navigationController.view.addGestureRecognizer(self.revealController.panGestureRecognizer())

        return navigationController
    }
}

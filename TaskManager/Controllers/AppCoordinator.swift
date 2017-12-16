//
//  AppCoordinator.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator: NSObject, RootCoordinator {

    var window: UIWindow!
    var revealController: SWRevealViewController!
    var childCoordinators: [Coordinator] = []

    var frontNavigation: NavigationController!

    override init() {
        super.init()
    }

    convenience init(window: UIWindow) {
        self.init()
        self.window = window
        self.configureNavigation()
    }

    // setuping menu and home controller
    func start() {
        let vc = self.configureTasksVc()

        self.revealController.rearViewController = self.configureMenuVc()
        self.revealController.frontViewController = vc
    }

    // setup reveal controller as root vc of app
    private func configureNavigation() {
        self.revealController = SWRevealViewController()
        self.revealController.delegate = self
        self.revealController.configure()
        self.window.rootViewController = self.revealController

    }

    // configuring side menu controller, one time in app
    private func configureMenuVc() -> MenuViewController{
        let menuVc = MenuViewController()

        // returning selected item from controller
        // if controller is already selected closing animation appears
        menuVc.onItemSelected = { [weak self] item in
            if let menuItem = item {
                self?.showVc(for: menuItem)
            } else {
                self?.revealController.setFrontViewPosition(.left, animated: true)
            }
        }

        return menuVc
    }

    // tasks are configured as home or as one of pushed controllers from menu
    private func configureTasksVc() -> NavigationController {
        let tasksVc = TasksViewController()
        // take reference of navigation
        self.frontNavigation = self.wrapWithNavVc(vc: tasksVc)
        // returning selected task from controller
        tasksVc.onTaskSelected = { [weak self] task in
            self?.showSingleTask(for: task)
        }
        return self.frontNavigation
    }

    // tasks are configured as home or as one of pushed controllers from menu
    private func configureProjectsVc() -> NavigationController {
        let tasksVc = ProjectsViewController()
        // take reference of navigation
        self.frontNavigation = self.wrapWithNavVc(vc: tasksVc)

        return self.frontNavigation
    }
    
    // configure color screen
    private func configureColorVc() -> NavigationController {
        let colorVc = ColorViewController()
        // take reference of navigation
        self.frontNavigation = self.wrapWithNavVc(vc: colorVc)

        return self.frontNavigation
    }

    // showing controllers depenging on selected item in menu
    private func showVc(for item: MenuItem) {
        switch item {
        case .tasks:
            let vc = self.configureTasksVc()
            self.revealController.pushFrontViewController(vc, animated: true)

        case .project:
            let vc = self.configureProjectsVc()
            self.revealController.pushFrontViewController(vc, animated: true)
        case .dashboard:
            let vc = self.configureColorVc()
            self.revealController.pushFrontViewController(vc, animated: true)

        default:
            let nc = self.wrapWithNavVc(vc: TestViewController())
            self.revealController.pushFrontViewController(nc, animated: true)

        }
        print("controller: ", item.title)

    }

    // single task
    private func showSingleTask(for item: TaskItem) {
        let vc = SingleTaskViewController(task: item)
        self.frontNavigation.pushViewController(vc, animated: true)
    }

    // task list
    private func showTasks() {
        let vc = self.configureTasksVc()
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

extension AppCoordinator: SWRevealViewControllerDelegate {

    func revealController(_ revealController: SWRevealViewController, willMoveTo position: FrontViewPosition) {
        guard let frontVc = revealController.frontViewController else {
            return
        }

        switch position {
        case .left:
            frontVc.view.isUserInteractionEnabled = true
        case .right:
            frontVc.view.isUserInteractionEnabled = true // false
        default:
            break
        }
    }
    
}

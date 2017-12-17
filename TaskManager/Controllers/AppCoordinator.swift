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
    }

    // setuping menu and home controller
    func start() {
        let vc = SplashViewController()
        vc.onFinish = { [weak self] in
            self?.moveForward()
        }

        self.window.rootViewController = vc

    }

    private func moveForward() {

        // taking shapshot to prepaire for animation
        guard let snap = self.window.snapshotView(afterScreenUpdates: true) else {
            self.configureStartNavigation()
            return
        }

        self.configureStartNavigation()
        self.window.addSubview(snap)

        var newFrame = snap.frame
        newFrame.origin.y = snap.frame.size.height * 2

        UIView.animate(withDuration: 0.33, delay: 0, options: .curveEaseIn, animations: {
            snap.frame = newFrame
            snap.alpha = 0
        }, completion: nil)

    }

    // setup reveal controller as root vc of app
    private func configureStartNavigation() {
        self.revealController = SWRevealViewController()
        self.revealController.delegate = self
        self.revealController.configure()

        let vc = self.configureProjectsVc()

        self.revealController.rearViewController = self.configureMenuVc(type: .menu)
        self.revealController.rightViewController = self.configureMenuVc(type: .settings)
        self.revealController.frontViewController = vc

        self.window.rootViewController = self.revealController
    }


    // configuring side menu controller, one time in app
    private func configureMenuVc(type: MenuType) -> MenuViewController{
        let menuVc = MenuViewController(type: type)

        // returning selected item from controller
        // if controller is already selected closing animation appears
        menuVc.onItemSelected = { [weak self] item in
            self?.showVc(for: item)
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
        print("controller: ", item.title)

        // check if front controller is kind already shown
        // front controller is wrapped in own navigation controller
        if let navVc = self.revealController.frontViewController as? NavigationController,
            let frontVc = navVc.viewControllers.first,
            type(of: frontVc) == item.vcType {
            self.revealController.setFrontViewPosition(.left, animated: true)
            return
        }

        switch item {
        case .tasks:
            let vc = self.configureTasksVc()
            self.revealController.pushFrontViewController(vc, animated: true)

        case .project:
            let vc = self.configureProjectsVc()
            self.revealController.pushFrontViewController(vc, animated: true)

        case .colorTheme:
            let vc = self.configureColorVc()
            self.revealController.pushFrontViewController(vc, animated: true)

        default:
            let nc = self.wrapWithNavVc(vc: TestViewController())
            self.revealController.pushFrontViewController(nc, animated: true)

        }

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

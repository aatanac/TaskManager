//
//  NavigationViewController.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {

    // on setup of navigation controller first controller is not setup as root
    // it is imported in viewcontrollers array for setting up initial appearance of navBar
    override var viewControllers: [UIViewController] {
        didSet {
            if oldValue.count == 0,
                let vc = self.viewControllers.first {
                self.configure(for: vc)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscribeToNotification()
        self.delegate = self
        self.navigationBar.isTranslucent = false
    }

    private func subscribeToNotification() {
        NotificationCenter.default.addObserver(forName: Notification.Name.apllyTheme, object: nil, queue: .main) { [weak self] (_) in
            let theme = ThemeManager.currentTheme()
            self?.navigationBar.barTintColor = theme.color
            self?.navigationBar.tintColor = theme.barItemsColor
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // all configuration of navigationBar is in navigation vc
    // controller does not know what is happening
    private func configure(for vc: UIViewController) {

        switch vc {
        case is TasksViewController:
            vc.title = "Tasks"
            self.configureNavBar(vc)

        case is MenuViewController:
            self.setNavBar(hidden: true)

        case is SingleTaskViewController:
            self.configureBtns(for: vc)
            vc.title = "Task"

        case is ProjectsViewController:
            self.configureNavBar(vc)
            vc.title = "Projects"

        case is TestViewController:
            self.configureBtns(for: vc)
            vc.title = "Not finished"

        case is ColorViewController:
            self.configureBtns(for: vc)
            vc.title = "Themes"

        default:
            print(vc.self)

        }
    }

    // separating configuring navigation bar for task vc
    private func configureNavBar(_ vc: UIViewController) {
        self.setNavBar(hidden: false)

        if #available(iOS 11.0, *) {
            vc.navigationItem.hidesSearchBarWhenScrolling = false
            vc.navigationController?.navigationBar.prefersLargeTitles = false
        }
        self.configureBtns(for: vc)
    }

    private func configureBtns(for vc: UIViewController) {
        vc.navigationItem.leftItemsSupplementBackButton = true
        
        // menu item has action that points to swreveals method for opeing/closing menu
        let menuBtn = UIBarButtonItem(image: Image.menu.image, style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        vc.navigationItem.leftBarButtonItems = [menuBtn]

        let settingsBtn = UIBarButtonItem(image: Image.settings.image, style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)))
        vc.navigationItem.rightBarButtonItems = [settingsBtn]

    }

    // avoid repeat code for hidding navBar
    private func setNavBar(hidden: Bool) {
        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = !hidden
        }
        self.setNavigationBarHidden(hidden, animated: true)
    }

}

extension NavigationController: UINavigationControllerDelegate {

    // with confirming to delegate and using this delegate method all logic is transfered out of controllers
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        self.configure(for: viewController)
    }

}

//
//  MenuViewController.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    let viewModel = MenuViewModel()

    var selectedIndexPath: IndexPath?

    var onItemSelected: ((_ item: MenuItem?) -> Void)?

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // removing empty cell separators
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

    var backgroundColor: UIColor = ThemeManager.currentTheme().color {
        didSet {
            self.view.backgroundColor = self.backgroundColor
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.configureTableView()
        self.subscribeToNotification()
    }

    private func configureTableView() {
        self.tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    private func configureUI() {
        self.view.backgroundColor = self.backgroundColor

        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
    }

    private func subscribeToNotification() {
        NotificationCenter.default.addObserver(forName: Notification.Name.apllyTheme, object: nil, queue: OperationQueue.main) { [weak self] (_) in
            self?.backgroundColor = ThemeManager.currentTheme().color

        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - Table view delegate
extension MenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedItem = self.selectedIndexPath,
            selectedItem.row == indexPath.row {
            self.onItemSelected?(nil)
            return
        }
        self.selectedIndexPath = indexPath
        let item = self.viewModel.item(for: indexPath)
        self.onItemSelected?(item)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MenuTableViewCell.height
    }

}

// MARK: - Table view data source
extension MenuViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        let item = self.viewModel.item(for: indexPath)
        cell.item = item
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }


}

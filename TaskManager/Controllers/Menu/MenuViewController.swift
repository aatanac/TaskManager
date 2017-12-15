//
//  MenuViewController.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class MenuViewController: BaseTableViewController {

    let viewModel = MenuViewModel()

    var onItemSelected: ((_ item: MenuItem) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.configureTableView()
    }

    private func configureTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

}

// MARK: - Table view delegate
extension MenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.item(for: indexPath)
        self.onItemSelected?(item)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = self.viewModel.item(for: indexPath)
        cell.textLabel?.text = item.title
        return cell
    }

}

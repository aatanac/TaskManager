//
//  ProjectsViewController.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class ProjectsViewController: BaseTableViewController {

    let viewModel = ProjectsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        super.configureUI()
        self.configureTableView()
        self.handleData()
    }

    private func configureTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func handleData() {
        self.searchController.searchResultsUpdater = self.viewModel

        self.viewModel.onReloadData = { [weak self] in
            self?.tableView.reloadData()
        }
        
        self.viewModel.fetchFromDB(query: nil) { (result) in
            print("Results", result)
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = self.viewModel.item(for: indexPath)
        cell.textLabel?.text = item.name

        return cell
    }

}

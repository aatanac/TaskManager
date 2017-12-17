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

    var onProjectSelected: ((_ project: Project) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        super.configureUI()
        self.configureTableView()
        self.handleData()
        self.configureRefresh()
    }

    private func configureTableView() {
        self.tableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: "ProjectTableViewCell")
    }

    private func handleData() {
        self.searchController.searchResultsUpdater = self.viewModel

        self.viewModel.onReloadData = { [weak self] in
            self?.tableView.reloadData()
        }
        self.viewModel.subscribeToDBNotification()

    }

    override func refreshData() {

        self.viewModel.refreshData { [weak self] (error) in
            self?.refreshControl?.endRefreshing()
            if let er = error {
                SnackBar.show(type: .error(error: er), onEndAnimation: nil)
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTableViewCell", for: indexPath) as? ProjectTableViewCell
        let item = self.viewModel.item(for: indexPath)
        cell?.item = item

        return cell!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ProjectTableViewCell.height
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.item(for: indexPath)
        self.onProjectSelected?(item)
    }

}

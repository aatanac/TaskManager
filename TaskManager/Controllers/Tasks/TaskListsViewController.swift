//
//  TaskListsViewController.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class TaskListsViewController: BaseTableViewController {

    let viewModel: TaskListViewModel

    var onListSelected: ((_ task: TaskList) -> Void)?

    init(project: Project) {
        self.viewModel = TaskListViewModel(project: project)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.configureUI()
        self.configureTableView()
        self.handleData()
        self.configureRefresh()
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

    override func refreshData() {

        self.viewModel.refreshData { [weak self] (_) in
            self?.refreshControl?.endRefreshing()
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.item(for: indexPath)
        self.onListSelected?(item)
    }

}

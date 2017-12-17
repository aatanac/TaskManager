//
//  TasksViewController.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

final class TasksViewController: BaseTableViewController {

    var viewModel: TasksViewModel

    var onTaskSelected: ((_ task: TaskItem) -> Void)?

    init(list: TaskList?) {
        self.viewModel = TasksViewModel(list: list)
        super.init(style: .plain)
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
        self.tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskTableViewCell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        let item = self.viewModel.item(for: indexPath)
        cell.item = item

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.item(for: indexPath)
        self.onTaskSelected?(item)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TaskTableViewCell.height
    }

}

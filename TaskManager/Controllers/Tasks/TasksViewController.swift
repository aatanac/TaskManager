//
//  TasksViewController.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/14/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

final class TasksViewController: UITableViewController {

    let viewModel = TasksViewModel()
    var searchController: UISearchController!

    var onTaskSelected: ((_ task: TaskItem) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.configureUI()
        self.handleData()
    }

    private func configureTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func configureUI() {

        self.clearsSelectionOnViewWillAppear = false

        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.hidesNavigationBarDuringPresentation = true
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.searchBar.searchBarStyle = .minimal
        self.searchController.searchBar.sizeToFit()

        self.searchController.searchResultsUpdater = self.viewModel
        self.searchController.searchBar.delegate = self

        if #available(iOS 11.0, *) {
            // For iOS 11 and later, pretty animation
            self.navigationItem.searchController = self.searchController
            // Search bar visible all the time
        } else {
            // For iOS 10 and earlier
            self.tableView.tableHeaderView = searchController.searchBar
        }

    }

    private func handleData() {
        self.viewModel.onReloadData = { [weak self] in
            self?.tableView.reloadData()
        }
        self.refreshData()
    }

    private func refreshData() {
        self.viewModel.refreshData { (error) in
            print(error?.localizedDescription ?? "data received")
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
        cell.textLabel?.text = item.content

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.item(for: indexPath)
        self.onTaskSelected?(item)
    }

}

// MARK: - UISearchBarDelegate
extension TasksViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}

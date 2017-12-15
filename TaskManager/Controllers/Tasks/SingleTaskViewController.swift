//
//  SingleTaskViewController.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class SingleTaskViewController: BaseTableViewController {

    var viewModel: SingleTaskViewModel!

    init(task: TaskItem) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = SingleTaskViewModel(task: task)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
extension SingleTaskViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

}

// MARK: - Table view data source
extension SingleTaskViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Test"
        return cell
    }

}

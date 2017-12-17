//
//  BaseTableViewController.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configureUI() {
        self.tableView.separatorStyle = .none
        self.clearsSelectionOnViewWillAppear = false

        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.searchBar.searchBarStyle = .prominent
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.delegate = self

        if #available(iOS 11.0, *) {
            // For iOS 11 and later, pretty animation
            self.navigationItem.searchController = self.searchController
            // set to false, bad animation on pushing controller with content greater than scrollView height
            self.navigationItem.hidesSearchBarWhenScrolling = false
            // Search bar visible all the time
        } else {
            // For iOS 10 and earlier
            self.tableView.tableHeaderView = searchController.searchBar
        }

    }

    func configureRefresh() {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        refresher.tintColor = .white
        self.refreshControl = refresher
    }

    @objc func refreshData() {}
    
    deinit {
        print("Deinit:  ", self)
    }

}

// MARK: - UISearchBarDelegate
extension BaseTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}


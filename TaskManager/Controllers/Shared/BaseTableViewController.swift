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

        self.clearsSelectionOnViewWillAppear = false

        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.hidesNavigationBarDuringPresentation = true
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.searchBar.searchBarStyle = .minimal
        self.searchController.searchBar.sizeToFit()
        //
        self.searchController.searchBar.tintColor = .white

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

}

// MARK: - UISearchBarDelegate
extension BaseTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}


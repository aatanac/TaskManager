//
//  SplashViewController.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/16/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    let viewModel = SplashViewModel()

    var onFinish: (() -> Void)?

    private let loadingLabel: LoadingLabel = {
        let label = LoadingLabel(frame: .zero)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    private func configureUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.loadingLabel)
        NSLayoutConstraint.activate([
            // centering label -30, label witdh with one dot is 60
            self.loadingLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -30),
            self.loadingLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetchData()
    }

    private func fetchData() {
        self.loadingLabel.startLoading()
        self.viewModel.fetchStartData { [weak self] (error) in
            self?.loadingLabel.stopLoading()
            if let er = error {
                print(er.localizedDescription)
            } else {
                self?.onFinish?()
            }
        }
    }

}

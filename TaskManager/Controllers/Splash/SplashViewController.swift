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
        self.fetchData()
    }

    private func configureUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.loadingLabel)
        NSLayoutConstraint.activate([
            // centering label -55, label witdh with one dot is 110
            self.loadingLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -55),
            self.loadingLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func fetchData() {
        self.loadingLabel.startLoading()
        self.viewModel.fetchStartData { [weak self] (error) in
            self?.loadingLabel.stopLoading()
            if error != nil {
                SnackBar.show(type: .error(error: .syncFailed), onEndAnimation: {
                    self?.onFinish?()
                })
            } else {
                self?.onFinish?()
            }
        }
    }

}

//
//  LoadingBtn.swift
//  UITest
//
//  Created by Aleksandar Atanackovic on 16/12/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

final class LoadingBtn: UIControl {

    enum LoadingState {
        case ´default´
        case loading

        var title: String {
            switch self {
            case .´default´:
                return "Save theme"
            case .loading:
                return "Saving.."
            }
        }

        var userInterection: Bool {
            switch self {
            case .´default´:
                return true
            case .loading:
                return false
            }
        }
    }

    var loadingState: LoadingState = .´default´ {
        didSet {
            self.handleChangeState()
        }
    }

    var onPressed: (() -> Void)?
    var onAnimationEnd: (() -> Void)?

    private let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(activityIndicatorStyle: .white)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()

    private let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.isUserInteractionEnabled = false
        label.font = Font.OpenSans.bold.font(size: 14)
        return label
    }()

    private var trailingToLoader: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
        self.configureActions()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {

        self.loader.stopAnimating()
        self.addSubview(self.loader)
        NSLayoutConstraint.activate([
            self.loader.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            self.loader.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])

        self.label.text = self.loadingState.title
        self.addSubview(self.label)
        self.trailingToLoader = self.label.trailingAnchor.constraint(equalTo: self.loader.leadingAnchor)
        self.trailingToLoader?.constant = self.loadingState == .´default´ ? self.loader.frame.size.width : -8

        NSLayoutConstraint.activate([
            self.trailingToLoader!,
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.label.centerYAnchor.constraint(equalTo: self.loader.centerYAnchor),
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
            ])
    }

    private func configureActions() {
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }

    @objc private func pressed() {
        self.changeState()
        self.onPressed?()

        // fake request to server, would be made in viewModel of controller
        // for simplicty is set here
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.changeState()
        }
    }

    private func changeState() {
        if self.loadingState == .loading {
            self.loadingState = .´default´
        } else {
            self.loadingState = .loading
        }
    }

    private func handleChangeState() {

        switch self.loadingState {
        case .loading:
            self.trailingToLoader?.constant = -8
            self.loader.startAnimating()
            self.isUserInteractionEnabled = self.loadingState.userInterection

        case .´default´:
            self.trailingToLoader?.constant = self.loader.frame.size.width
            self.loader.stopAnimating()

        }

        UIView.animate(withDuration: 0.2, animations: {
            self.label.text = self.loadingState.title
            self.layoutIfNeeded()
        }) { (_) in
            self.isUserInteractionEnabled = self.loadingState.userInterection

            if self.loadingState == .´default´ {
                self.onAnimationEnd?()
            }
        }
    }

    deinit {
        print("Deinit self")
    }

}

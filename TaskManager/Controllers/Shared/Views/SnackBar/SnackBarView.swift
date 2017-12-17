//
//  SnackBar.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class SnackBar: UIView {

    typealias AnimationBlock = (() -> Void)?

    private static let shared = SnackBar(frame: .zero)

    var type: SnackBarType = .message(msg: "") {
        didSet {
            self.configureUI(by: self.type)
        }
    }
    static let height: CGFloat = 50

    var bottomAncorSnackBar: NSLayoutConstraint?

    let titleLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = Font.OpenSans.regular.font(size: 14)
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI(by type: SnackBarType) {
        self.backgroundColor = type.bgColor
        self.titleLabel.text = type.message
    }

    private func configureUI() {
        self.configureUI(by: self.type)
        self.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
            ])
    }

    static func configure() {
        SnackBar.shared.configure()
    }

    // called only once on start of app
    // for this purpose is set added to window for showing in all screens to avoid UIAlertView
    private func configure() {
        guard let rootVc = UIWindow.rootVc else{
            assertionFailure("no window, please check configure logic")
            return
        }

        SnackBar.shared.translatesAutoresizingMaskIntoConstraints = false
        rootVc.view.addSubview(SnackBar.shared)

        SnackBar.shared.bottomAncorSnackBar = SnackBar.shared.bottomAnchor.constraint(equalTo: rootVc.view.bottomAnchor, constant: SnackBar.height)
        NSLayoutConstraint.activate([
            SnackBar.shared.bottomAncorSnackBar!,
            SnackBar.shared.heightAnchor.constraint(equalToConstant: SnackBar.height),
            SnackBar.shared.leadingAnchor.constraint(equalTo: rootVc.view.leadingAnchor),
            SnackBar.shared.trailingAnchor.constraint(equalTo: rootVc.view.trailingAnchor)
            ])
        self.superview?.layoutIfNeeded()
    }

    static func show(type: SnackBarType, onEndAnimation: AnimationBlock) {
        let snackBar = SnackBar.shared

        if snackBar.superview == nil {
            self.configure()
        }
        snackBar.superview?.bringSubview(toFront: snackBar)
        snackBar.configureUI(by: type)

        snackBar.bottomAncorSnackBar?.constant = 0
        let openAnimation = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1) {
            snackBar.superview?.layoutIfNeeded()
        }

        let closeAnimation = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1) {
            snackBar.superview?.layoutIfNeeded()
        }

        openAnimation.addCompletion { (position) in
            switch position {
            case .end:
                snackBar.bottomAncorSnackBar?.constant = SnackBar.height
                closeAnimation.startAnimation(afterDelay: 2.0)
            default:
                print(position)
            }
        }

        closeAnimation.addCompletion { (position) in
            switch position {
            case .end:
                onEndAnimation?()
                snackBar.removeFromSuperview()
            default:
                print(position)
            }
        }

        openAnimation.startAnimation()
    }

}



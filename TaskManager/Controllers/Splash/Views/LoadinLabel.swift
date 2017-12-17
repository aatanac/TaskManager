//
//  LoadinLabel.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class LoadingLabel: UILabel {

    var count: Int = 0 {
        didSet {
            self.text = self.textLoading + String(repeating: ".", count: self.count)
        }
    }

    let textLoading = "Loading "

    var timer: Timer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configureUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .black
        self.isUserInteractionEnabled = false
        self.font = Font.OpenSans.regular.font(size: 14)
        self.text = self.textLoading
        self.textAlignment = .left
    }

    func startLoading() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (_) in
            if self.count < 4 {
                self.count += 1
            } else {
                self.count = 0
            }
        })
    }

    func stopLoading() {
        timer?.invalidate()
        timer = nil
    }

}

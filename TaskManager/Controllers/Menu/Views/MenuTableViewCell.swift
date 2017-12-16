//
//  MenuTableViewCell.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    static let height: CGFloat = 50

    let imageIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.OpenSans.bold.font(size: 15)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()

    var item: MenuItem? {
        didSet {
            self.configure(with: self.item)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configureUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear

        self.contentView.addSubview(self.imageIcon)
        NSLayoutConstraint.activate([
            self.imageIcon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.imageIcon.heightAnchor.constraint(equalToConstant: 20),
            self.imageIcon.widthAnchor.constraint(equalToConstant: 20),
            self.imageIcon.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
            ])

        self.contentView.addSubview(self.label)
        NSLayoutConstraint.activate([
            self.label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.label.leadingAnchor.constraint(equalTo: self.imageIcon.trailingAnchor, constant: 16)
            ])

    }

    private func configure(with item: MenuItem?) {
        guard let menuItem = item else { return }
        self.imageIcon.image = menuItem.icon
        self.label.text = menuItem.title
    }

}

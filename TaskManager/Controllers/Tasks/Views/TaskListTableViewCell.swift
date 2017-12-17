//
//  TaskListTableViewCell.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class TaskListTableViewCell: UITableViewCell {

    private static let imgSize: CGFloat = 20
    static let height: CGFloat = 60

    let listImage: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.image = Image.activity.imageTemplate
        imgView.tintColor = Color.gray
        imgView.clipsToBounds = true
        return imgView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.isUserInteractionEnabled = false
        label.font = Font.OpenSans.bold.font(size: 16)
        label.numberOfLines = 1
        return label
    }()

    private let descLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.isUserInteractionEnabled = false
        label.font = Font.OpenSans.regular.font(size: 14)
        label.numberOfLines = 2
        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.isUserInteractionEnabled = false
        label.font = Font.OpenSans.bold.font(size: 14)
        label.numberOfLines = 1
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 2
        label.textAlignment = .center
        return label
    }()

    var item: TaskList? {
        didSet {
            self.configure(for: self.item)
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

        self.contentView.addSubview(self.listImage)
        NSLayoutConstraint.activate([
            self.listImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.listImage.heightAnchor.constraint(equalToConstant: TaskListTableViewCell.imgSize),
            self.listImage.widthAnchor.constraint(equalToConstant: TaskListTableViewCell.imgSize),
            self.listImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8)
            ])

        self.contentView.addSubview(self.countLabel)
        NSLayoutConstraint.activate([
            self.countLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.countLabel.heightAnchor.constraint(equalToConstant: 30),
            self.countLabel.widthAnchor.constraint(equalToConstant: 30),
            self.countLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8)
            ])

        self.contentView.addSubview(self.nameLabel)
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.listImage.trailingAnchor, constant: 8),
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.countLabel.leadingAnchor, constant: -8)
            ])

        self.contentView.addSubview(self.descLabel)
        NSLayoutConstraint.activate([
            self.descLabel.leadingAnchor.constraint(equalTo: self.listImage.trailingAnchor, constant: 8),
            self.descLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
            self.descLabel.heightAnchor.constraint(equalToConstant: 20),
            self.descLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.countLabel.leadingAnchor, constant: -8)
            ])
    }

    private func configure(for item: TaskList?) {
        guard let taskList = item else {
            return
        }
        self.nameLabel.text = taskList.name
        self.descLabel.text = taskList.desc
        self.countLabel.text = "\(taskList.count)"
    }

}


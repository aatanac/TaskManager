//
//  TaskTableViewCell.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/17/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    private static let buttonSize: CGFloat = 40
    static let height: CGFloat = 60

    let finishButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(Image.checkmark.imageTemplate, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
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

    private let dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.isUserInteractionEnabled = false
        label.font = Font.OpenSans.regular.font(size: 14)
        label.numberOfLines = 1
        return label
    }()

    var item: TaskItem? {
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

        self.contentView.addSubview(self.finishButton)
        NSLayoutConstraint.activate([
            self.finishButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.finishButton.heightAnchor.constraint(equalToConstant: TaskTableViewCell.buttonSize),
            self.finishButton.widthAnchor.constraint(equalToConstant: TaskTableViewCell.buttonSize),
            self.finishButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8)
            ])

        self.contentView.addSubview(self.nameLabel)
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.finishButton.trailingAnchor, constant: 8),
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8)
            ])

        self.contentView.addSubview(self.dateLabel)
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: self.finishButton.trailingAnchor, constant: 8),
            self.dateLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
            self.dateLabel.heightAnchor.constraint(equalToConstant: 20),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8)
            ])
    }

    private func configure(for item: TaskItem?) {
        guard let task = item else {
            return
        }
        self.nameLabel.text = task.content
        if let date = task.createdOn {
            self.dateLabel.text =  DateManager.dateString(from: date)
        } else {
            self.dateLabel.text = " - "
        }

        if let status = TaskStatus(rawValue: task.status) {
            self.finishButton.isHidden = false
            self.finishButton.tintColor = status.color
        } else {
            self.finishButton.isHidden = true
        }

    }

}

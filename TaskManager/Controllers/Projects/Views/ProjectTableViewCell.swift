//
//  ProjectTableViewCell.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/16/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    static let height: CGFloat = 80
    private static let imgSize: CGFloat = 30
    private static let buttonSize: CGFloat = 40

    let logoImage: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.image = Image.star.imageTemplate
        imgView.layer.cornerRadius = ProjectTableViewCell.imgSize / 2
        imgView.clipsToBounds = true
        return imgView
    }()

    let starButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(Image.star.imageTemplate, for: .normal)
        return btn
    }()

    private let labelProjName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.isUserInteractionEnabled = false
        label.font = Font.OpenSans.bold.font(size: 16)
        label.numberOfLines = 1
        return label
    }()

    private let labelCompName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.isUserInteractionEnabled = false
        label.font = Font.OpenSans.regular.font(size: 14)
        label.numberOfLines = 1
        return label
    }()

    private let labelDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.isUserInteractionEnabled = false
        label.font = Font.OpenSans.regular.font(size: 11)
        label.numberOfLines = 2
        return label
    }()

    var item: Project? {
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

        self.contentView.addSubview(self.logoImage)
        NSLayoutConstraint.activate([
            self.logoImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.logoImage.heightAnchor.constraint(equalToConstant: ProjectTableViewCell.imgSize),
            self.logoImage.widthAnchor.constraint(equalToConstant: ProjectTableViewCell.imgSize),
            self.logoImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8)
            ])

        self.contentView.addSubview(self.starButton)
        NSLayoutConstraint.activate([
            self.starButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.starButton.heightAnchor.constraint(equalToConstant: ProjectTableViewCell.buttonSize),
            self.starButton.widthAnchor.constraint(equalToConstant: ProjectTableViewCell.buttonSize),
            self.starButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8)
            ])

        self.contentView.addSubview(self.labelProjName)
        NSLayoutConstraint.activate([
            self.labelProjName.leadingAnchor.constraint(equalTo: self.logoImage.trailingAnchor, constant: 8),
            self.labelProjName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.labelProjName.trailingAnchor.constraint(equalTo: self.starButton.leadingAnchor, constant: -8)
            ])

        self.contentView.addSubview(self.labelCompName)
        NSLayoutConstraint.activate([
            self.labelCompName.leadingAnchor.constraint(equalTo: self.logoImage.trailingAnchor, constant: 8),
            self.labelCompName.topAnchor.constraint(equalTo: self.labelProjName.bottomAnchor),
            self.labelCompName.heightAnchor.constraint(equalToConstant: 20),
            self.labelCompName.trailingAnchor.constraint(equalTo: self.starButton.leadingAnchor, constant: -8)
            ])

        self.contentView.addSubview(self.labelDescription)
        NSLayoutConstraint.activate([
            self.labelDescription.leadingAnchor.constraint(equalTo: self.logoImage.trailingAnchor, constant: 8),
            self.labelDescription.topAnchor.constraint(equalTo: self.labelCompName.bottomAnchor),
            self.labelDescription.trailingAnchor.constraint(equalTo: self.starButton.leadingAnchor, constant: -8)
            ])

    }

    private func configure(for item: Project?) {
        guard let project = item else {
            return
        }

        self.logoImage.setImage(with: project.logo)
        self.labelProjName.text = project.name
        self.labelCompName.text = project.company?.name
        self.labelDescription.text = project.desc
        self.starButton.tintColor = project.starred ? Color.yellow : Color.gray

    }

}

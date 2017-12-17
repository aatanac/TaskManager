//
//  ProjectTableViewCell.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/16/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    let selectedImg: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.image = Image.star.imageTemplate
        return imgView
    }()

    private let labelCompName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.isUserInteractionEnabled = false
        label.font = Font.OpenSans.regular.font(size: 14)
        return label
    }()

    private let labelProjName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.isUserInteractionEnabled = false
        label.font = Font.OpenSans.bold.font(size: 16)
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configureUI() {
        
    }

}

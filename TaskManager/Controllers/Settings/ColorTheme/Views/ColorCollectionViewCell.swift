//
//  ColorCollectionViewCell.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {

    static let size = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
    private static let inset = ColorCollectionViewCell.size.width / 10

    let circleView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = (size.width - 2 * ColorCollectionViewCell.inset) / 2
        return view
    }()

    let selectedImg: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.image = Image.tick.imageTemplate
        imgView.tintColor = .white
        return imgView
    }()

    var item: Theme = .brown {
        didSet {
            self.circleView.backgroundColor = self.item.color
        }
    }

    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.selectedImg.isHidden = !self.isSelected
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        self.selectedImg.isHidden = !self.isSelected

        self.contentView.addSubview(self.circleView)
        NSLayoutConstraint.activate([
            self.circleView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: ColorCollectionViewCell.inset),
            self.circleView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -ColorCollectionViewCell.inset),
            self.circleView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: ColorCollectionViewCell.inset),
            self.circleView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -ColorCollectionViewCell.inset)
            ])

        self.contentView.addSubview(self.selectedImg)
        NSLayoutConstraint.activate([
            self.selectedImg.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.selectedImg.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.selectedImg.heightAnchor.constraint(equalToConstant: ColorCollectionViewCell.size.height / 2),
            self.selectedImg.widthAnchor.constraint(equalToConstant: ColorCollectionViewCell.size.width / 2)
            ])

    }

}

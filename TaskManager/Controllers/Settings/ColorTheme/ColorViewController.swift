//
//  ColorViewController.swift
//  TaskManager
//
//  Created by Aleksandar Atanackovic on 12/15/17.
//  Copyright © 2017 Aleksandar Atanackovic. All rights reserved.
//

import UIKit

final class ColorViewController: UIViewController {

    let viewModel = ColorViewModel()

    static let bottomViewHeight: CGFloat = 50

    let collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: ColorViewController.bottomViewHeight, right: 0)
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        return collection
    }()

    let bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    let loadingBtn: LoadingBtn = {
        let loadingBtn = LoadingBtn(frame: .zero)
        loadingBtn.translatesAutoresizingMaskIntoConstraints = false
        loadingBtn.layer.cornerRadius = 5
        return loadingBtn
    }()

    private var theme = ThemeManager.currentTheme {
        didSet {
            self.applyTheme()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.configureCollectionView()
        self.configureActions()
    }

    private func configureUI() {
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])

        self.view.addSubview(self.bottomView)
        NSLayoutConstraint.activate([
            self.bottomView.heightAnchor.constraint(equalToConstant: ColorViewController.bottomViewHeight),
            self.bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])

        self.bottomView.addSubview(self.loadingBtn)
        NSLayoutConstraint.activate([
            self.loadingBtn.trailingAnchor.constraint(equalTo: self.bottomView.trailingAnchor, constant: -8),
            self.loadingBtn.centerYAnchor.constraint(equalTo: self.bottomView.centerYAnchor)
            ])

        self.applyTheme()
    }

    private func configureActions() {
        
        self.loadingBtn.onAnimationEnd = { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.viewModel.applyTheme(weakSelf.theme)
        }

    }

    private func configureCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: "ColorCollectionViewCell")
        let selectedIndexPath = IndexPath(row: self.theme.rawValue, section: 0)
        self.collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
    }

    private func applyTheme() {
        self.loadingBtn.backgroundColor = self.theme.color
    }

    deinit {
        print("Deinit:  ", self)
    }

}

extension ColorViewController: UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        self.theme = self.viewModel.item(for: indexPath)
    }

}

extension ColorViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as! ColorCollectionViewCell
        cell.item = self.viewModel.item(for: indexPath)

        return cell
    }

}


//
//  LocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 13.09.2022.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let dataSource = DataSource()
    private let delegate = EmojiCollectionViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
        collectionView.register(LocationCollectionViewCell.self, forCellWithReuseIdentifier: LocationCollectionViewCell.reuseIdentifier)
        collectionView.register(TitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        view.addSubview(collectionView)
    }
    
    private func configureLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 50, height: 50)
        return layout
    }
}

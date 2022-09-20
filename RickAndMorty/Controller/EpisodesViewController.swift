//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    enum Section {
        case Episodes
    }
    
    private var collectionView: UICollectionView!
    private let dataSource = EpisodesDataSource()
    private let delegate = EpisodesDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        createCollectionView()
    }
    
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
        collectionView.register(EpisodesCollectionViewCell.self, forCellWithReuseIdentifier: EpisodesCollectionViewCell.reuseIdentifier)
        collectionView.register(TitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        view.addSubview(collectionView)
    }
    
    private func configureLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 30)
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }
    
    private func setupViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constans.Text.Titles.episodes
        view.backgroundColor = .systemBlue
    }
}

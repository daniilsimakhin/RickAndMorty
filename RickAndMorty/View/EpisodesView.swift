//
//  EpisodesView.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 29.09.2022.
//

import UIKit

class EpisodesView: UIView {
    
    //MARK: - Variables
    private(set) var collectionView: UICollectionView!
    var dataSource: EpisodesDataSource?
    var delegate: EpisodesDelegate?
    
    //MARK: - Func view
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private func
    private func createCollectionView() {
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: configureLayout())
        collectionView.register(EpisodeCollectionViewCell.self, forCellWithReuseIdentifier: EpisodeCollectionViewCell.reuseIdentifier)
        collectionView.register(TitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = C.Colors.CollectionView.background
        
        addSubview(collectionView)
    }
    
    private func configureLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: frame.width, height: 30)
        return layout
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension EpisodesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - 20, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(indexPath: indexPath)
    }
}

//MARK: - UICollectionViewDataSource
extension EpisodesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let episodes = dataSource?.episodes else { return 0 }
        return episodes.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.reuseIdentifier, for: indexPath) as? EpisodeCollectionViewCell else {
            fatalError("Cannot create EpisodeCollectionViewCell")
        }
        guard let episode = dataSource?.episodes?.results[indexPath.row] else { return cell }
        cell.configure(episode)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier, for: indexPath) as? TitleCollectionReusableView else {
            fatalError("Cannot create TitleCollectionReusableView")
        }
        guard let pages = dataSource?.episodes?.info.pages else { return header }
        header.configure("Page (\(dataSource?.page ?? 0)/\(pages))")
        return header
    }
}

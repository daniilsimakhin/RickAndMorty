//
//  EpisodesDataSource.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 16.09.2022.
//

import UIKit

class EpisodesDataSource: NSObject, UICollectionViewDataSource {
    
    let emoji = Emoji.shared
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = emoji.sections[section]
        if let emoji = emoji.data[category] {
            return emoji.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodesCollectionViewCell.reuseIdentifier, for: indexPath) as? EpisodesCollectionViewCell else {
            fatalError("Cannot create EpisodesCollectionViewCell")
        }
        let category = emoji.sections[indexPath.section]
        cell.configure("S01E01", "Pilot", "DECEMBER 2, 2013")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier, for: indexPath) as? TitleCollectionReusableView else {
            fatalError("Cannot create TitleCollectionReusableView")
        }
        let category = emoji.sections[indexPath.section]
        header.titleLabel.text = category.rawValue
        
        return header
    }
}

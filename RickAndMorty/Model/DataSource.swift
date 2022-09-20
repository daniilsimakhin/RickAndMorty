//
//  DataSource.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 13.09.2022.
//

import UIKit

class DataSource: NSObject, UICollectionViewDataSource {
    
    let emoji = Emoji.shared
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emoji.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = emoji.sections[section]
        if let emoji = emoji.data[category] {
            return emoji.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.reuseIdentifier, for: indexPath) as? LocationCollectionViewCell else {
            fatalError("Cannot create LocationCollectionViewCell")
        }
        let category = emoji.sections[indexPath.section]
        cell.configure(emoji.data[category]?[indexPath.row] ?? "0", "asd")
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

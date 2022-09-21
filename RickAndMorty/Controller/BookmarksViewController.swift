//
//  BookmarksViewController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    enum Section: String, CaseIterable {
        case locations = "Locations"
        case characters = "Characters"
        case episodes = "Episodes"
    }
    
    private var collectionView: UICollectionView!
    private var data: [Section: Int] = [.locations: 12, .characters: 10, .episodes: 10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        createCollectionView()
    }
    
    private func setupViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constans.Text.Titles.bookmarks
    }
    
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LocationCollectionViewCell.self, forCellWithReuseIdentifier: LocationCollectionViewCell.reuseIdentifier)
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
        collectionView.register(EpisodesCollectionViewCell.self, forCellWithReuseIdentifier: EpisodesCollectionViewCell.reuseIdentifier)
        collectionView.register(TitleWithDisclosureCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleWithDisclosureCollectionReusableView.reuseIdentifier)
        view.addSubview(collectionView)
    }
    
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionNumber, env in
            switch sectionNumber {
            case 0:
                return self.createLocationsSection()
            case 1:
                return self.createCharactersSection()
            default:
                return self.createEpisodesSection()
            }
        })
        return layout
    }
    
    private func createLocationsSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
        return section
    }
    
    private func createCharactersSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.65))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
        return section
    }
    
    private func createEpisodesSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
        return section
    }
}

extension BookmarksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension BookmarksViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = Section.allCases[section]
        return data[category] ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.reuseIdentifier, for: indexPath) as? LocationCollectionViewCell else {
                fatalError("Cannot create BookmarksLocationCollectionViewCell")
            }
//            cell.configure("Earth (C-137)", "Planet")
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
                fatalError("Cannot create CharacterCollectionViewCell")
            }
//            cell.configure(UIImage(named: "test")!)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodesCollectionViewCell.reuseIdentifier, for: indexPath) as? EpisodesCollectionViewCell else {
                fatalError("Cannot create EpisodesCollectionViewCell")
            }
            cell.configure("S01E01", "Pilot", "DECEMBER 2, 2013")
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleWithDisclosureCollectionReusableView.reuseIdentifier, for: indexPath) as? TitleWithDisclosureCollectionReusableView else {
            fatalError("Cannot create TitleWithDisclosureCollectionReusableView")
        }
        let section = Section.allCases[indexPath.section].rawValue
        header.configure(section)
        return header
    }
}

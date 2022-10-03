//
//  DetailView.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 02.10.2022.
//

import UIKit

protocol DetailViewDataSource {
    func getSection(numberSection: Int) -> Section
    func numberOfSections() -> Int
    func numberOfItemsInSection(numberSection: Int) -> Int
    
    func getInformation() -> ([String], String?)
    func getAdditionalInformation(_ indexPath: IndexPath) -> [String]?
    func getCharacters(_ indexPath: IndexPath) -> Character?
    func getEpisodes(_ indexPath: IndexPath) -> Episode?
}

protocol DetailViewDelegate {
    func pushViewController(_ vc: UIViewController)
}

class DetailView: UIView {
    //MARK: - Variables
    private(set) var collectionView: UICollectionView!
    var dataSource: DetailViewDataSource!
    var delegate: DetailViewDelegate!

    //MARK: - View func
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupViewController()
    }

    //MARK: - Private func
    private func setupViewController() {
        addSubview(collectionView)
    }

    private func createCollectionView() {
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: configureLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeaderCollectionViewCell.reuseIdentifier)
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.reuseIdentifier)
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
        collectionView.register(EpisodeCollectionViewCell.self, forCellWithReuseIdentifier: EpisodeCollectionViewCell.reuseIdentifier)
        collectionView.register(TitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier)
    }

    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionNumber, env in
            let section = self.dataSource.getSection(numberSection: sectionNumber)
            switch section {
            case .information:
                return self.createHeaderSection()
            case .additionalInformation:
                return self.createInformationSection()
            case .characters:
                return self.createCharactersSection()
            case .episodes:
                return self.createEpisodesSection()
            }})
        return layout
    }

    private func createHeaderSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        var heightDimension: CGFloat = 0
        if dataSource.getInformation().1 == nil {
            heightDimension = 100
        } else {
            heightDimension = 300
        }
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(heightDimension))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    private func createInformationSection() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
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

//MARK: - UICollectionViewDataSource
extension DetailView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfItemsInSection(numberSection: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = dataSource.getSection(numberSection: indexPath.section)
        switch section {
        case .information:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.reuseIdentifier, for: indexPath) as? HeaderCollectionViewCell else {
                fatalError("Cannot create BookmarksLocationCollectionViewCell")
            }
            let information = dataSource.getInformation()
            cell.configure(information.0, information.1)
            return cell
        case .additionalInformation:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.reuseIdentifier, for: indexPath) as? DetailCollectionViewCell else {
                fatalError("Cannot create EpisodeCollectionViewCell")
            }
            guard let additionalInformation = dataSource.getAdditionalInformation(indexPath) else { return cell }
            cell.configure(additionalInformation[0], additionalInformation[1])
            return cell
        case .episodes:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.reuseIdentifier, for: indexPath) as? EpisodeCollectionViewCell else {
                fatalError("Cannot create EpisodeCollectionViewCell")
            }
            guard let episode = dataSource.getEpisodes(indexPath) else { return cell }
            cell.configure(episode)
            return cell
        case .characters:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
                fatalError("Cannot create CharacterCollectionViewCell")
            }
            guard let character = dataSource.getCharacters(indexPath) else { return cell }
            cell.configure(character)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier, for: indexPath) as? TitleCollectionReusableView else {
            fatalError("Cannot create TitleCollectionReusableView")
        }
        let section = dataSource.getSection(numberSection: indexPath.section)
        header.configure(section.rawValue)
        return header
    }
}

//MARK: - UICollectionViewDelegate
extension DetailView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = dataSource.getSection(numberSection: indexPath.section)
        switch section {
        case .information:
            break
        case .additionalInformation:
            break
        case .characters:
            guard let character = dataSource.getCharacters(indexPath) else { return }
            let detailVC = DetailViewController(.getCharacter(character: character))
            delegate.pushViewController(detailVC)
        case .episodes:
            guard let episode = dataSource.getEpisodes(indexPath) else { return }
            let detailVC = DetailViewController(.getEpisode(episode: episode))
            delegate.pushViewController(detailVC)
        }
    }
}

//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import UIKit

class CharactersViewController: UIViewController {
    enum Section {
        case characters
    }

    private var collectionView: UICollectionView!
    private var characters: Characters?
    var dataSource: UICollectionViewDiffableDataSource<Section, Character>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        createCollectionView()
        NetworkService.shared.getCharacters { [weak self] result in
            switch result {
            case .success(let data):
                self?.characters = data
                var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Character>()
                initialSnapshot.appendSections([.characters])
                initialSnapshot.appendItems(self?.characters?.results ?? [], toSection: .characters)
                self?.dataSource.apply(initialSnapshot, animatingDifferences: true)
            case .failure(let error):
                print("Error with get characters \(error.localizedDescription)")
            }
        }
    }
    
    private func setupViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constans.Text.Titles.characters
        view.backgroundColor = .systemGreen
    }
    
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
        collectionView.delegate = self
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
        configureDataSource()
        view.addSubview(collectionView)
    }
    
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.65))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Character>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
                fatalError("Cannot create \(CharacterCollectionViewCell.self)")
            }
            if let character = self.characters?.results[indexPath.row] {
                cell.configure(character)
            }
            return cell
        })
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Character>()
        initialSnapshot.appendSections([.characters])
        initialSnapshot.appendItems(characters?.results ?? [], toSection: .characters)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
}

extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewSize = scrollView.contentSize.height - scrollView.frame.height + (tabBarController?.tabBar.frame.height ?? 0)
        let scrollViewCurrentPosition = scrollViewSize - scrollView.contentOffset.y
        if scrollViewCurrentPosition < scrollViewSize / 4 {
            print(scrollViewCurrentPosition)
            //Загрузка новой страницы
        }
    }
}

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

    private var page = 1
    private var characters: Characters?
    var dataSource: UICollectionViewDiffableDataSource<Section, Character>!
    private var refreshControl = UIRefreshControl()
    private var collectionView: UICollectionView!
    private let countLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .systemOrange.withAlphaComponent(0.5)
        view.textColor = .black.withAlphaComponent(0.75)
        view.font = .systemFont(ofSize: 15, weight: .bold)
        view.numberOfLines = 1
        view.textAlignment = .center
        view.layer.cornerRadius = 8.5
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        createCollectionView()
        setPage(at: page)
    }
    
    //MARK: - Private func
    
    private func setupViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constans.Text.Titles.characters
        view.backgroundColor = .systemGreen
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
        collectionView.delegate = self
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
        configureDataSource()
        collectionView.refreshControl = refreshControl
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        collectionView.addSubview(countLabel)
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
    
    private func setPage(at value: Int) {
        guard ServiceLayer.pagination == false else { return }
        if page == characters?.info.pages { return }
        if let info = characters?.info {
            if page + value > 0 && page + value <= info.pages {
                page += value
            }
        }
        ServiceLayer.request(router: .getCharacters(page: page)) { [weak self] (result: Result<Characters, Error>) in
            switch result {
            case .success(let success):
                if self?.characters == nil {
                    self?.characters = success
                } else {
                    self?.characters?.results.append(contentsOf: success.results)
                }
                var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Character>()
                initialSnapshot.appendSections([.characters])
                initialSnapshot.appendItems(self?.characters?.results ?? [], toSection: .characters)
                DispatchQueue.main.async {
                    self?.dataSource.apply(initialSnapshot, animatingDifferences: true)
                    self?.countLabel.text = "\(self?.characters?.results.count ?? 0)/\(self!.characters?.info.count ?? 0)"
                }
            case .failure(let failure):
                print("Error with get characters \(failure.localizedDescription)")
            }
        }
    }
    
    //MARK: - @objc private func
    
    @objc private func refresh() {
        refreshControl.endRefreshing()
    }
}

//MARK: - UICollectionViewDelegate

extension CharactersViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let navBarHeight = navigationController!.navigationBar.subviews[0].frame.height - 0.5
        let tabBarHeight = tabBarController!.tabBar.frame.height
        let localHeight = scrollView.contentSize.height - scrollView.frame.height + navBarHeight + tabBarHeight
        let currentPosition = scrollView.contentOffset.y + navBarHeight
        let normalizeCurrentPosition = currentPosition / localHeight
        if localHeight - currentPosition < 100 && localHeight - currentPosition > -100 {
            setPage(at: 1)
        }
        let position = normalizeCurrentPosition * (scrollView.contentSize.height - 25)
        countLabel.frame = CGRect(x: view.frame.width - 75, y: position, width: 70, height: 20)
        countLabel.text = "\(characters?.results.count ?? 0)/\(characters?.info.count ?? 0)"
    }
}

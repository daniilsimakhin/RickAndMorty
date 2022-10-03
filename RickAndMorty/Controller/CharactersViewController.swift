//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import UIKit

class CharactersViewController: UIViewController {
    
    //MARK: - Private variables
    private var page = 1
    private var characters: Characters!
    private var dataSource: UICollectionViewDiffableDataSource<TabBarSection, Character>!
    private var characterView: CharactersView!
    private var characterViewInput: CharactersViewInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setPage(at: page)
    }
    
    //MARK: - Private func
    private func setupViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = C.Text.Titles.characters
        characterView = CharactersView(frame: view.frame)
        characterView.viewOutput = self
        characterViewInput = characterView
        view = characterView
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
                    self?.configureDataSource()
                } else {
                    self?.characters?.results.append(contentsOf: success.results)
                }
                self?.createSnapshot(.characters, self?.characters.results ?? [])
            case .failure(let failure):
                print("Error with get characters \(failure.localizedDescription)")
            }
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<TabBarSection, Character>(collectionView: characterView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
                fatalError("Cannot create \(CharacterCollectionViewCell.self)")
            }
            if let character = self.characters?.results[indexPath.row] {
                cell.configure(character)
            }
            return cell
        })
        createSnapshot(.characters, characters.results)
        characterViewInput?.setAmountCharacters(characters?.results.count ?? 0, characters?.info.count ?? 0)
    }
    
    private func createSnapshot(_ section: TabBarSection, _ items: [Character]) {
        var snapshot = NSDiffableDataSourceSnapshot<TabBarSection, Character>()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - CharactersViewOutput
extension CharactersViewController: CharactersViewOutput {
    func didSelectItemAt(_ indexPath: IndexPath) {
        guard let character = characters?.results[indexPath.row] else { return }
        let detailVC = DetailViewController(.getCharacter(character: character))
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let navBarHeight = navigationController!.navigationBar.subviews[0].frame.height - 0.5
        let tabBarHeight = tabBarController!.tabBar.frame.height
        let localHeight = scrollView.contentSize.height - scrollView.frame.height + navBarHeight + tabBarHeight
        let currentPosition = scrollView.contentOffset.y + navBarHeight
        if localHeight - currentPosition < 100 && localHeight - currentPosition > -100 {
            setPage(at: 1)
        }
        let normalizeCurrentPosition = currentPosition / localHeight
        let position = normalizeCurrentPosition * (scrollView.contentSize.height - 25)
        characterViewInput?.setPositionAmountCharactersLabel(position)
        characterViewInput?.setAmountCharacters(characters?.results.count ?? 0, characters?.info.count ?? 0)
    }
}

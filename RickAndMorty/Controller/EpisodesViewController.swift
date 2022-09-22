//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    enum Section {
        case episodes
    }
    
    private var page: Int = 1
    private var collectionView: UICollectionView!
    private var episodes: Episodes? {
        didSet {
            guard let info = episodes?.info else {
                navigationItem.leftBarButtonItem?.isEnabled = true
                return
            }
            if info.prev == nil {
                navigationItem.leftBarButtonItem?.isEnabled = false
            } else {
                navigationItem.leftBarButtonItem?.isEnabled = true
            }
            if info.next == nil {
                navigationItem.rightBarButtonItem?.isEnabled = false
            } else {
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createCollectionView()
        ServiceLayer.request(router: .getEpisodes(page: page)) { (result:  Result<Episodes, Error>) in
            switch result {
            case .success(let success):
                self.episodes = success
                self.collectionView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
        //проверить на утечку памяти
    }
    
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
        collectionView.register(EpisodesCollectionViewCell.self, forCellWithReuseIdentifier: EpisodesCollectionViewCell.reuseIdentifier)
        collectionView.register(TitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    private func configureLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 30)
        return layout
    }
    
    private func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let prevPageButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left.circle"), style: .done, target: self, action: #selector(pageButtonTapped))
        prevPageButton.tag = 0
        let nextPageButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right.circle"), style: .done, target: self, action: #selector(pageButtonTapped))
        nextPageButton.tag = 1
        navigationItem.rightBarButtonItem = nextPageButton
        navigationItem.leftBarButtonItem = prevPageButton
        title = Constans.Text.Titles.episodes
        view.backgroundColor = .systemBlue
    }
    
    @objc private func pageButtonTapped(sender: UIBarButtonItem!) {
        switch sender.tag {
        case 0:
            setPage(at: -1)
        case 1:
            setPage(at: 1)
        default:
            return
        }
        ServiceLayer.request(router: .getEpisodes(page: page)) { (result:  Result<Episodes, Error>) in
            switch result {
            case .success(let success):
                self.episodes = success
                self.collectionView.reloadData()
            case .failure(let failure):
                print(failure)
            }
            //проверить на утечку памяти
        }
    }
    
    private func setPage(at value: Int) {
        if let info = episodes?.info {
            if page + value > 0 && page + value <= info.pages {
                page += value
            }
        }
    }
}

extension EpisodesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes?.results.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodesCollectionViewCell.reuseIdentifier, for: indexPath) as? EpisodesCollectionViewCell else {
            fatalError("Cannot create EpisodesCollectionViewCell")
        }
        if let episode = episodes?.results[indexPath.row] {
            cell.configure(episode.episode, episode.name, episode.air_date)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier, for: indexPath) as? TitleCollectionReusableView else {
            fatalError("Cannot create TitleCollectionReusableView")
        }
        guard let pages = episodes?.info.pages else { return header }
        header.configure("Page (\(page)/\(pages))")
        return header
    }
}

extension EpisodesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
}

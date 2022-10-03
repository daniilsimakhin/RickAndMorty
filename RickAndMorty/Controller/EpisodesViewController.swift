//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    var page: Int = 1
    private var episodesView: EpisodesView!
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
        setPage(at: page)
        //проверить на утечку памяти
    }
    
    private func configureLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 30)
        return layout
    }
    
    private func configureUI() {
        episodesView = EpisodesView(frame: view.frame)
        episodesView.dataSource = self
        episodesView.delegate = self
        view = episodesView
        
        navigationController?.navigationBar.prefersLargeTitles = true
        let prevPageButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left.circle"), style: .done, target: self, action: #selector(pageButtonTapped))
        prevPageButton.tag = 0
        let nextPageButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right.circle"), style: .done, target: self, action: #selector(pageButtonTapped))
        nextPageButton.tag = 1
        navigationItem.rightBarButtonItem = nextPageButton
        navigationItem.leftBarButtonItem = prevPageButton
        title = C.Text.Titles.episodes
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
    }
    
    private func setPage(at value: Int) {
        if let info = episodes?.info {
            if page + value > 0 && page + value <= info.pages {
                page += value
            }
        }
        ServiceLayer.request(router: .getEpisodes(page: page)) { (result:  Result<Episodes, Error>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.episodes = success
                    self.episodesView.collectionView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
            //проверить на утечку памяти
        }
    }
}

//MARK: - EpisodesViewDataSource
extension EpisodesViewController: EpisodesViewDataSource {
    func getEpisodes() -> Episodes? {
        return episodes
    }
}

//MARK: - EpisodesViewDelegate
extension EpisodesViewController: EpisodesViewDelegate {
    func didSelectItemAt(indexPath: IndexPath) {
        guard let episode = episodes?.results[indexPath.row] else { return }
        let detailVC = DetailViewController(.getEpisode(episode: episode))
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

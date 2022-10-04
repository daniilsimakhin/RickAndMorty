//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import UIKit

protocol EpisodesDataSource {
    var page: Int {get}
    var episodes: Episodes? {get}
}

protocol EpisodesDelegate {
    func didSelectItemAt(indexPath: IndexPath)
}

class EpisodesViewController: UIViewController, EpisodesDataSource {
    //MARK: - Variables
    private var episodesView: EpisodesView!
    private(set) var page: Int = 1
    private(set) var episodes: Episodes? {
        didSet {
            guard let info = episodes?.info else {
                navigationItem.leftBarButtonItem?.isEnabled = false
                navigationItem.rightBarButtonItem?.isEnabled = false
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
    
    //MARK: - View func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setPage(at: page)
    }
    
    //MARK: - Private func
    private func setupUI() {
        episodesView = EpisodesView(frame: view.frame)
        episodesView.dataSource = self
        episodesView.delegate = self
        view = episodesView
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = createBarButtonItem(C.Images.NavBar.EpisodesView.rightBarButton, #selector(pageButtonTapped(sender:)), 1)
        navigationItem.leftBarButtonItem = createBarButtonItem(C.Images.NavBar.EpisodesView.leftBarButton, #selector(pageButtonTapped(sender:)), 0)
        title = C.Text.Titles.episodes
    }
    
    private func createBarButtonItem(_ imagePath: String, _ action: Selector, _ tag: Int) -> UIBarButtonItem {
        let button = UIBarButtonItem(image: UIImage(systemName: imagePath), style: .done, target: self, action: action)
        button.tag = tag
        return button
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
        }
    }
    
    //MARK: - @objc func
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
    
}

//MARK: - EpisodesViewDelegate
extension EpisodesViewController: EpisodesDelegate {
    func didSelectItemAt(indexPath: IndexPath) {
        guard let episode = episodes?.results[indexPath.row] else { return }
        let detailVC = DetailViewController(.getEpisode(episode: episode))
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

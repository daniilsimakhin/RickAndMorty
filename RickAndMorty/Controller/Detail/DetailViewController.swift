//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 01.10.2022.
//

import UIKit

enum Section: String, CaseIterable {
    case information = "Information"
    case additionalInformation = "Additional information"
    case characters = "Characters"
    case episodes = "Episodes"
}

class DetailViewController: UIViewController {
    //MARK: - Variables
    private var detailView: DetailView!
    private let detail: DetailInfo
    private var characters: [Character]?
    private var episodes: [Episode]?
    private var sectionsData: [Int: Int] = [:]
    
    init(_ detailInfo: DetailInfo) {
        detail = detailInfo
        sectionsData[0] = 1
        if let information = detail.additionalInformation {
            sectionsData[1] = information.count
        }
        if let characters = detail.characters, characters.count > 0 {
            sectionsData[2] = characters.count
        }
        if let episodes = detail.episodes, episodes.count > 0 {
            sectionsData[3] = episodes.count
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setupViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = detail.title
        detailView = DetailView(frame: view.frame)
        detailView.dataSource = self
        detailView.delegate = self
        view = detailView
        if let characters = detail.characters {
            if characters.count > 1 {
                let numberEpisodes = characters.map { str in
                    String(str.split(separator: "/").last ?? "")
                }
                ServiceLayer.request(router: .getMultipleCharacters(members: numberEpisodes)) { (result: Result<[Character], Error>) in
                    switch result {
                    case .success(let success):
                        self.characters = success
                        self.detailView.collectionView.reloadData()
                    case .failure(let failure):
                        print(failure)
                    }
                }
            } else if characters.count == 1 {
                let id = Int(String(characters[0].split(separator: "/").last ?? ""))
                ServiceLayer.request(router: .getCharacter(at: id!)) { (result: Result<Character, Error>) in
                    switch result {
                    case .success(let success):
                        self.characters = [success]
                        self.detailView.collectionView.reloadData()
                    case .failure(let failure):
                        print(failure)
                    }
                }
            } else {
                return
            }
        }
//        if let information = detail.additionalInformation {
//            data[1] = information.count
//        }
        if let episodes = detail.episodes {
            if episodes.count > 1 {
                let numberEpisodes = episodes.map { str in
                    String(str.split(separator: "/").last ?? "")
                }
                ServiceLayer.request(router: .getMultipleEpisodes(members: numberEpisodes)) { (result: Result<[Episode], Error>) in
                    switch result {
                    case .success(let success):
                        self.episodes = success
                        self.detailView.collectionView.reloadData()
                    case .failure(let failure):
                        print(failure)
                    }
                }
            } else if episodes.count == 1 {
                let id = String(episodes[0].split(separator: "/").last ?? "")
                ServiceLayer.request(router: .getMultipleEpisodes(members: [id])) { (result: Result<Episode, Error>) in
                    switch result {
                    case .success(let success):
                        self.episodes = [success]
                        self.detailView.collectionView.reloadData()
                    case .failure(let failure):
                        print(failure)
                    }
                }
            } else {
                return
            }
        }
    }
}

//MARK: - DetailViewDataSource
extension DetailViewController: DetailViewDataSource {
    func getAdditionalInformation(_ indexPath: IndexPath) -> [String]? {
        let header = ["Gender", "Origin", "Type", "Location"]
        if let info = detail.additionalInformation {
            return [header[indexPath.row], info[indexPath.row]]
        }
        return nil
    }
    
    func getInformation() -> ([String], String?) {
        return (detail.information, detail.image)
    }
    
    func getCharacters(_ indexPath: IndexPath) -> Character? {
        guard let character = characters?[indexPath.row] else { return nil }
        return character
    }
    
    func getEpisodes(_ indexPath: IndexPath) -> Episode? {
        guard let episode = episodes?[indexPath.row] else { return nil }
        return episode
    }
    
    func getSection(numberSection: Int) -> Section {
        let sortedSections = self.sectionsData.keys.sorted(by: <)
        let section = Section.allCases[sortedSections[numberSection]]
        return section
    }
    
    func numberOfSections() -> Int {
        return sectionsData.keys.count
    }
    
    func numberOfItemsInSection(numberSection: Int) -> Int {
        let sortedSections = self.sectionsData.keys.sorted(by: <)
        let key = sortedSections[numberSection]
        return sectionsData[key] ?? 1
    }
}

//MARK: - DetailViewDelegate
extension DetailViewController: DetailViewDelegate {
    func pushViewController(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

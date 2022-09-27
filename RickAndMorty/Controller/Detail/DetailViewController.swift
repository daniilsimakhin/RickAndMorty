//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 26.09.2022.
//

import UIKit

class DetailViewController: UIViewController {

    enum Division: String, CaseIterable {
        case informations
        case episodes
    }
    
    private var character: Character!
    private var tableView: UITableView!
    private var dataSource: UITableViewDiffableDataSource<Division, String>!
    private var informations = [String]()
    private var episodes = [String]()
    private var headers = ["Gender", "Origin", "Type", "Location"]
    private var header = DetailTableViewHeader(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 2, height: 275))
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        createSnapshot(division: .informations, items: [
            "\(character.gender.capitalized)",
            "\(character.origin.name.capitalized)",
            "\(character.type == "" ? "Unknown" : character.type.capitalized)",
            "\(character.location.name) ",
        ])
        createSnapshot(division: .episodes, items: ["asd", "aasdasd"])
        
        let numberEpisodes = character.episode.map { str in
            String(str.split(separator: "/").last ?? "")
        }
        ServiceLayer.request(router: .getMultipleEpisodes(members: numberEpisodes)) { (result: Result<[Episode], Error>) in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    //MARK: - Private func
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
        tableView.register(DetailTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: DetailTableViewHeaderFooterView.reuseIdentifier)
        configureDataSource()
        tableView.delegate = self
        tableView.tableHeaderView = header
        view.addSubview(tableView)
    }
    
    private func createSnapshot(division: Division, items: [String]) {
        switch division {
        case .informations:
            informations += items
        case .episodes:
            episodes += items
        }
        var initialSnapshot = NSDiffableDataSourceSnapshot<Division, String>()
        initialSnapshot.appendSections(Division.allCases)
        initialSnapshot.appendItems(informations, toSection: .informations)
        initialSnapshot.appendItems(episodes, toSection: .episodes)
        DispatchQueue.main.async {
            self.dataSource.apply(initialSnapshot, animatingDifferences: true)
        }
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Division, String>(tableView: self.tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath) as? DetailTableViewCell else { fatalError("Cannot create \(DetailTableViewCell.self)") }
            if indexPath.section == 0 {
                cell.configure(self.headers[indexPath.row], itemIdentifier, nil)
            } else {
                cell.configure(nil, itemIdentifier, nil)
            }
            return cell
        })
    }
    
    //MARK: - Public func
    func configure(_ data: Character) {
        self.character = data
        title = data.name
        header.configure(character: data)
    }
}

//MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailTableViewHeaderFooterView.reuseIdentifier) as? DetailTableViewHeaderFooterView else { return UITableViewHeaderFooterView()}
        let category = Division.allCases[section]
        header.configure(category.rawValue)
        return header
    }
}

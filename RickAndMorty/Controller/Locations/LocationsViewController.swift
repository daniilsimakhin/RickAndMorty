//
//  LocationsViewController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import UIKit

class LocationsViewController: UIViewController {
    
    //MARK: - Private variables
    private var locations: Locations!
    private var locationsView: LocationsView!
    private var dataSource: UICollectionViewDiffableDataSource<TabBarSection, Location>!
    private var page = 1
    
    //MARK: - Func view controllers
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        ServiceLayer.request(router: .getLocations(page: page)) { [weak self]  (result: Result<Locations, Error>) in
            switch result {
            case .success(let success):
                self?.locations = success
                self?.configureDataSource()
            case .failure(let failure):
                print("Error with get locations: \(failure.localizedDescription)")
            }
        }
    }
    
    //MARK: - Private func
    private func setupViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = C.Text.Titles.locations
        locationsView = LocationsView(frame: view.frame)
        locationsView.output = self
        view = locationsView
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<TabBarSection, Location>(collectionView: locationsView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.reuseIdentifier, for: indexPath) as? LocationCollectionViewCell else {
                fatalError("Cannot create \(LocationCollectionViewCell.self)")
            }
            cell.location = self.locations.results[indexPath.row]
            return cell
        })
        createSnapshot(section: .locations, locations: locations)
    }
    
    private func createSnapshot(section: TabBarSection, locations: Locations) {
        var snapshot = NSDiffableDataSourceSnapshot<TabBarSection, Location>()
        snapshot.appendSections([section])
        snapshot.appendItems(locations.results, toSection: section)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

//MARK: - LocationsViewTapHandler
extension LocationsViewController: LocationsViewOutput {
    
    func didSelectItemAt(_ indexPath: IndexPath) {
        let detailVC = DetailViewController(.getLocation(location: locations.results[indexPath.row]))
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

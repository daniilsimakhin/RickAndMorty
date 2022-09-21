//
//  LocationsViewController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import UIKit

class LocationsViewController: UIViewController {
    enum Section {
        case locations
    }
    
    private var collectionView: UICollectionView!
    private var locations: Locations?
    private var dataSource: UICollectionViewDiffableDataSource<Section, Location>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        createCollectionView()
        NetworkService.shared.getLocations { [weak self] result in
            switch result {
            case .success(let data):
                self?.locations = data
                var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Location>()
                initialSnapshot.appendSections([.locations])
                initialSnapshot.appendItems(self?.locations?.results ?? [], toSection: .locations)
                self?.dataSource.apply(initialSnapshot, animatingDifferences: true)
            case .failure(let error):
                print("Error with get locations \(error.localizedDescription)")
            }
        }
    }
    
    private func setupViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constans.Text.Titles.locations
        view.backgroundColor = .systemRed
    }
    
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
        collectionView.delegate = self
        collectionView.register(LocationCollectionViewCell.self, forCellWithReuseIdentifier: LocationCollectionViewCell.reuseIdentifier)
        collectionView.register(TitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier)
        configureDataSource()
        view.addSubview(collectionView)
    }
    
    private func configureLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 30)
        return layout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Location>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.reuseIdentifier, for: indexPath) as? LocationCollectionViewCell else {
                fatalError("Cannot create \(LocationCollectionViewCell.self)")
            }
            if let location = self.locations?.results[indexPath.row] {
                cell.configure(location)
            }
            return cell
        })
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier,
                for: indexPath) as? TitleCollectionReusableView
            view?.configure("Test")
            return view
        }
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Location>()
        initialSnapshot.appendSections([.locations])
        initialSnapshot.appendItems(locations?.results ?? [], toSection: .locations)
        
        dataSource.apply(initialSnapshot, animatingDifferences: true)
    }
}

extension LocationsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}

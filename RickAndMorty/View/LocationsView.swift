//
//  LocationsView.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 27.09.2022.
//

import UIKit

enum Section {
    case locations
}

protocol LocationsViewTapHandler {
    func pressedOnCell(_ indexPath: IndexPath)
}

class LocationsView: UIView {
    
    //MARK: - Public variables
    var delegate: LocationsViewTapHandler!
    
    //MARK: - Private variables
    private var collectionView: UICollectionView!
    private var locations: Locations!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Location>!
    
    //MARK: - Func view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private func
    private func setupViewController() {
        isUserInteractionEnabled = true
    }

    private func createCollectionView() {
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: configureLayout())
        collectionView.delegate = self
        collectionView.register(LocationCollectionViewCell.self, forCellWithReuseIdentifier: LocationCollectionViewCell.reuseIdentifier)
        collectionView.register(TitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier)
        configureDataSource()
        addSubview(collectionView)
    }
    
    private func configureLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: frame.width, height: 30)
        return layout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Location>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.reuseIdentifier, for: indexPath) as? LocationCollectionViewCell else {
                fatalError("Cannot create \(LocationCollectionViewCell.self)")
            }
            cell.configure(self.locations.results[indexPath.row])
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
        createSnapshot(section: .locations, locations: locations)
    }
    
    private func createSnapshot(section: Section, locations: Locations) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Location>()
        snapshot.appendSections([section])
        snapshot.appendItems(locations.results, toSection: section)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    //MARK: - Public func
    func configure(_ locations: Locations) {
        self.locations = locations
        createCollectionView()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension LocationsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.pressedOnCell(indexPath)
    }
}

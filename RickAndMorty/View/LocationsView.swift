//
//  LocationsView.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 27.09.2022.
//

import UIKit

protocol LocationsViewOutput {
    func didSelectItemAt(_ indexPath: IndexPath)
}

class LocationsView: UIView {
    
    //MARK: - Private variables
    private(set) var collectionView: UICollectionView!
    
    //MARK: - Public variables
    var output: LocationsViewOutput!
    
    //MARK: - Func view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewController()
        createCollectionView()
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
        collectionView.register(RefreshCollectionViewCell.self, forCellWithReuseIdentifier: RefreshCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = C.Colors.CollectionView.background
        addSubview(collectionView)
    }
    
    private func configureLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
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
        output.didSelectItemAt(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.contentOffset.y >= (collectionView.contentSize.height - collectionView.frame.size.height) {
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.color = UIColor.darkGray
            spinner.hidesWhenStopped = true
            collectionView.addSubview(spinner)
//            collectionView.footerview = spinner
        }
    }
}

//
//  RefreshCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 29.09.2022.
//

import UIKit

class RefreshCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Public variables
    static var reuseIdentifier = String(describing: RefreshCollectionViewCell.self)
    
    //MARK: - UI
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    
    //MARK: - Func view
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private func
    private func configureUI() {
        contentView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        activityIndicatorView.frame = contentView.frame
    }
}

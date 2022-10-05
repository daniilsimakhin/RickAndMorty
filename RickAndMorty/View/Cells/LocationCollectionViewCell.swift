//
//  LocationCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 15.09.2022.
//

import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    //MARK: - Variables
    static let reuseIdentifier = String(describing: LocationCollectionViewCell.self)
    var location: Location! {
        didSet {
            nameLabel.text = location.name.capitalized
            typeLabel.text = location.type.capitalized
            dimensionLabel.text = location.dimension.capitalized
        }
    }
    
    //MARK: - UI
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        return view
    }()
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .title2)
        view.textColor = C.Colors.Font.main
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    private let dimensionLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .subheadline)
        view.textColor = C.Colors.Font.secondary
//        view.textAlignment = .left
        return view
    }()
    private let typeLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .subheadline)
        view.textColor = C.Colors.Font.secondary
//        view.textAlignment = .left
        return view
    }()
    
    //MARK: - Func view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private func
    private func setupUI() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(dimensionLabel)
        
        clipsToBounds = true
        layer.cornerRadius = 20
        backgroundColor = C.Colors.Cell.background
        
        stackView.frame = CGRect(x: 15, y: 10, width: contentView.frame.width - 30, height: contentView.frame.height - 20)
    }
}

//
//  LocationCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 15.09.2022.
//

import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: LocationCollectionViewCell.self)
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 25, weight: .semibold)
        view.textAlignment = .left
        return view
    }()
    private let dimensionLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textAlignment = .left
        return view
    }()
    private let typeLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textAlignment = .left
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(dimensionLabel)
        contentView.addSubview(UIView.createGradientLayer(frame))
        
        clipsToBounds = true
        layer.cornerRadius = 20
        backgroundColor = .systemGray6
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.1
        
        stackView.frame = CGRect(x: 20, y: 10, width: contentView.frame.width - 40, height: contentView.frame.height - 20)
    }
    
    func configure(_ location: Location) {
        nameLabel.text = location.name
        typeLabel.text = location.type
        dimensionLabel.text = location.dimension
    }
}

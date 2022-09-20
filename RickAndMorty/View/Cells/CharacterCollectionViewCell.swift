//
//  CharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 15.09.2022.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: CharacterCollectionViewCell.self)
    
    private let characterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 1
        return view
    }()
    private let nameTextView: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 100, weight: .semibold)
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.1
        view.textAlignment = .left
        return view
    }()
    private let statusTextView: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 50, weight: .light)
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.1
        view.textAlignment = .left
        return view
    }()
    private let speciesTextView: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 50, weight: .light)
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.1
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
        contentView.addSubview(characterImageView)
        contentView.addSubview(UIView.createGradientLayer(frame))
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameTextView)
        stackView.addArrangedSubview(statusTextView)
        stackView.addArrangedSubview(speciesTextView)
        
        clipsToBounds = true
        layer.cornerRadius = 20
        backgroundColor = .systemGray5
        
        characterImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        stackView.frame = CGRect(x: 5, y: characterImageView.frame.maxY, width: frame.width - 10, height: frame.height - characterImageView.frame.height - 15)
    }
    
    func configure(_ image: UIImage) {
        characterImageView.image = image
        nameTextView.text = "Rick Sanchez"
        statusTextView.text = "Alive"
        speciesTextView.text = "Human"
    }
}

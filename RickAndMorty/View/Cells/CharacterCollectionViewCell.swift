//
//  CharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 15.09.2022.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: CharacterCollectionViewCell.self)
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()
    private let characterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 1
        return view
    }()
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .headline)
        view.numberOfLines = 1
        view.textAlignment = .left
        return view
    }()
    private let statusLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .subheadline)
        view.textAlignment = .left
        return view
    }()
    private let speciesLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .subheadline)
        view.textAlignment = .left
        view.textColor = C.Colors.Font.secondary
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
        characterImageView.frame = CGRect(x: 5, y: 5, width: frame.width - 10, height: frame.width - 5)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        stackView.frame = CGRect(x: 5, y: characterImageView.frame.maxY, width: frame.width - 10, height: frame.height - characterImageView.frame.height - 15)
        contentView.addSubview(characterImageView)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(speciesLabel)
        
        clipsToBounds = true
        layer.cornerRadius = 20
        backgroundColor = C.Colors.Cell.background

        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 0.5
        
        let path = UIBezierPath(roundedRect: characterImageView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 17.5, height: 17.5))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        characterImageView.layer.mask = mask
    }
    
    func configure(_ character: Character) {
        characterImageView.image = nil
        activityIndicator.startAnimating()
        UIImage.download(character.image, completion: { image in
            self.characterImageView.image = image
            self.activityIndicator.stopAnimating()
#warning("@ToDo: проверить на утечки памяти")
        })
        nameLabel.text = character.name.capitalized
        statusLabel.text = character.status.capitalized
        speciesLabel.text = character.species.capitalized
        if character.status == "Alive" {
            statusLabel.textColor = .systemGreen
        } else if character.status == "Dead" {
            statusLabel.textColor = .systemRed
        } else if character.status == "unknown" {
            statusLabel.textColor = C.Colors.Font.secondary
        }
    }
}

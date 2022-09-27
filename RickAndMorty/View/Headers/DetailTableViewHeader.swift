//
//  DetailTableViewHeader.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 26.09.2022.
//

import UIKit

class DetailTableViewHeader: UIView {
    
    //MARK: - UIViews
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "test")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var statusLabel: UILabel = {
        let view = UILabel()
        view.text = "statusLabel"
        view.font = .preferredFont(forTextStyle: .body)
        view.adjustsFontSizeToFitWidth = true
        view.textAlignment = .center
        return view
    }()
    private lazy var speciesLabel: UILabel = {
        let view = UILabel()
        view.text = "speciesLabel"
        view.font = .preferredFont(forTextStyle: .footnote)
        view.textColor = .gray
        view.adjustsFontSizeToFitWidth = true
        view.textAlignment = .center
        return view
    }()
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private func
    private func setupUI() {
        addSubview(imageView)
        addSubview(stackView)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(speciesLabel)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: frame.width),
            imageView.widthAnchor.constraint(equalToConstant: frame.width),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -10),
            
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
        
        imageView.layer.cornerRadius = frame.width / 2
        imageView.layer.masksToBounds = true
    }
    
    //MARK: - Public func
    func configure(character: Character) {
        UIImage.download(character.image) { [weak self] image in
            self?.imageView.image = image
            self?.statusLabel.text = character.status.capitalized
            self?.speciesLabel.text = character.species.uppercased()
        }
    }
}

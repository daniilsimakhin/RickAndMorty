//
//  HeaderCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 01.10.2022.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    //MARK: - Public variables
    static let reuseIdentifier = String(describing: HeaderCollectionViewCell.self)
    
    //MARK: - UIViews
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.text = "nameLabel"
        view.font = .preferredFont(forTextStyle: .title3)
        view.adjustsFontSizeToFitWidth = true
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var statusLabel: UILabel = {
        let view = UILabel()
        view.text = "statusLabel"
        view.font = .preferredFont(forTextStyle: .body)
        view.adjustsFontSizeToFitWidth = true
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var speciesLabel: UILabel = {
        let view = UILabel()
        view.text = "speciesLabel"
        view.font = .preferredFont(forTextStyle: .footnote)
        view.textColor = .gray
        view.adjustsFontSizeToFitWidth = true
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    //MARK: - Private func
    private func setupUI() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(speciesLabel)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(lessThanOrEqualToConstant: frame.width / 2),
            
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            statusLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            speciesLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
    }
    
    //MARK: - Public func
    func configure(_ titles: [String], _ imageUrl: String?) {
        if let url = imageUrl {
            imageView.setImageFrom(url)
            imageView.isHidden = false
        } else {
            imageView.isHidden = true
        }
        statusLabel.text = titles[0].capitalized
        nameLabel.text = titles[1].capitalized
        speciesLabel.text = titles[2].uppercased()
        
    }
}

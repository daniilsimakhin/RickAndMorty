//
//  DetailCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 26.09.2022.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    //MARK: - Variables
    static let reuseIdentifier = String(describing: DetailCollectionViewCell.self)
    
    //MARK: - UIViews
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Test"
        view.font = .preferredFont(forTextStyle: .headline)
        return view
    }()
    private lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Test"
        view.font = .preferredFont(forTextStyle: .callout)
        view.textColor = .gray
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
    
    //MARK: - View func
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    //MARK: - Private func
    private func configureUI() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ])
    }
    
    //MARK: - Public func
    func configure(_ title: String?, _ subtitle: String?) {
        titleLabel.text = title?.capitalized
        subtitleLabel.text = subtitle?.capitalized
//        titleLabel.text = title
//        subtitleLabel.text = subtitle
//        dateLabel.text = dateTitle
    }
}

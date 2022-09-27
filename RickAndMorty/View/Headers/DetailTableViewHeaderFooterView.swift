//
//  DetailTableViewHeaderFooterView.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 27.09.2022.
//

import UIKit

class DetailTableViewHeaderFooterView: UITableViewHeaderFooterView {
    //MARK: - Variables
    static let reuseIdentifier = String(describing: DetailTableViewHeaderFooterView.self)
    
    //MARK: - UIViews
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .title1)
        view.adjustsFontSizeToFitWidth = true
        view.textColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Inits
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private func
    private func setupUI() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ])
    }
    
    //MARK: - Public func
    func configure(_ title: String) {
        titleLabel.text = title.capitalized
    }
}

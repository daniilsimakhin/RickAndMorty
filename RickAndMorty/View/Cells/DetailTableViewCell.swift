//
//  DetailTableViewCell.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 26.09.2022.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    //MARK: - Variables
    static let reuseIdentifier = String(describing: DetailTableViewCell.self)
    
    //MARK: - UIViews
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Test"
        view.font = .systemFont(ofSize: 20, weight: .light)
        return view
    }()
    private lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Test"
        view.font = .systemFont(ofSize: 20, weight: .light)
        view.textColor = .gray
        return view
    }()
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.text = "Test"
        view.font = .systemFont(ofSize: 20, weight: .light)
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
    
    //MARK: - Internal func
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private func
    private func configureUI() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(dateLabel)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ])
    }
    
    //MARK: - Public func
    func configure(_ title: String?, _ subtitle: String?, _ dateTitle: String?) {
        let attributedText = NSMutableAttributedString(string: "\(title)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20 , weight: .bold)])
        attributedText.append(NSAttributedString(string: "\n\(subtitle)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "\n\(dateTitle)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .light)]))
        titleLabel.attributedText = attributedText
        titleLabel.text = title
//        subtitleLabel.text = subtitle
//        dateLabel.text = dateTitle
    }
}

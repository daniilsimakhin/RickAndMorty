//
//  EpisodesCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 14.09.2022.
//

import UIKit

class EpisodesCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: EpisodesCollectionViewCell.self)
    
    private let episodeTextView: UILabel = {
        let episodeTextView = UILabel()
        episodeTextView.font = .systemFont(ofSize: 20, weight: .medium)
        episodeTextView.textColor = .black
        episodeTextView.textAlignment = .left
        episodeTextView.numberOfLines = 0
        episodeTextView.backgroundColor = .clear
        return episodeTextView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(episodeTextView)
        contentView.addSubview(UIView.createGradientLayer(frame))
        clipsToBounds = true
        layer.cornerRadius = 20
        episodeTextView.frame = CGRect(x: 20, y: 0, width: contentView.frame.width - 40, height: contentView.frame.height)
    }
    
    func configure(_ season: String, _ name: String, _ date: String) {
        let attributedText = NSMutableAttributedString(string: "\(season)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20 , weight: .bold)])
        attributedText.append(NSAttributedString(string: "\n\(name)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "\n\(date)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .light)]))
        episodeTextView.attributedText = attributedText
    }
}

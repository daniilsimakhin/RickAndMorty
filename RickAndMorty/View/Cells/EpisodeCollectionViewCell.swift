//
//  EpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 14.09.2022.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: EpisodeCollectionViewCell.self)
    
    private let episodeTextView: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .medium)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.backgroundColor = .clear
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
        contentView.addSubview(episodeTextView)
        
        clipsToBounds = true
        layer.cornerRadius = 20
        backgroundColor = C.Colors.Cell.background
                
        episodeTextView.frame = CGRect(x: 20, y: 0, width: contentView.frame.width - 40, height: contentView.frame.height)
    }
    
    func configure(_ episode: Episode) {
        let attributedText = NSMutableAttributedString(string: "\(episode.name)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20 , weight: .bold)])
        attributedText.append(NSAttributedString(string: "\n\(episode.episode)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "\n\(episode.air_date)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .light)]))
        episodeTextView.attributedText = attributedText
    }
}

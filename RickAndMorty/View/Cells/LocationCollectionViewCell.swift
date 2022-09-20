//
//  LocationCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 15.09.2022.
//

import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: LocationCollectionViewCell.self)
    
    private let locationTextView: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .medium)
        view.textColor = .black
        view.textAlignment = .center
        view.numberOfLines = 4
        view.backgroundColor = .clear
        view.adjustsFontSizeToFitWidth = true
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
        contentView.addSubview(locationTextView)
        contentView.addSubview(UIView.createGradientLayer(frame))
        clipsToBounds = true
        layer.cornerRadius = 20
        locationTextView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
    }
    
    func configure(_ season: String, _ name: String) {
        let attributedText = NSMutableAttributedString(string: "\(name)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12 , weight: .light)])
        attributedText.append(NSAttributedString(string: "\n\(season)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)]))
        locationTextView.attributedText = attributedText
    }
}

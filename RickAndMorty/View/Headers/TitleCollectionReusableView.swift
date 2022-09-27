//
//  TitleCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 13.09.2022.
//

import UIKit

class TitleCollectionReusableView: UICollectionReusableView {
    
    static let reuseIdentifier = String(describing: TitleCollectionReusableView.self)
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        backgroundColor = .white
        titleLabel.frame = CGRect(x: frame.width / 10 / 2, y: 0, width: frame.width, height: frame.height)
    }
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}

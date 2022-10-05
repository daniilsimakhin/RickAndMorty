//
//  TitleCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 13.09.2022.
//

import UIKit

class TitleCollectionReusableView: UICollectionReusableView {
    //MARK: - Variables
    static let reuseIdentifier = String(describing: TitleCollectionReusableView.self)
    
    //MARK: - UI
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .title2)
        view.tintColor = C.Colors.Font.main
        return view
    }()
    
    //MARK: - View func
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private func
    private func setupUI() {
        addSubview(titleLabel)
        backgroundColor = C.Colors.CollectionView.background
        let inset = frame.width / 10 / 2
        titleLabel.frame = CGRect(x: inset, y: 0, width: frame.width - inset * 2, height: frame.height)
    }
    
    //MARK: - Public func
    func configure(_ title: String) {
        titleLabel.text = title
    }
}

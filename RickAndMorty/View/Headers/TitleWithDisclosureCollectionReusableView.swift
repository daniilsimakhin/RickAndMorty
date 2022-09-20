//
//  TitleWithDisclosureCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 14.09.2022.
//

import UIKit

class TitleWithDisclosureCollectionReusableView: UICollectionReusableView {
    
    static let reuseIdentifier = String(describing: TitleWithDisclosureCollectionReusableView.self)
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .title2)
        return view
    }()
    private let allButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        view.tintColor = .black
        view.contentHorizontalAlignment = .right
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
        addSubview(titleLabel)
        addSubview(allButton)
        let inset = frame.width / 10 / 2
        titleLabel.frame = CGRect(x: inset, y: 0, width: frame.width - 2 * inset - 50, height: frame.height)
        allButton.frame = CGRect(x: frame.width - 50 - titleLabel.frame.minX, y: 0, width: 50, height: frame.height)
    }
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}

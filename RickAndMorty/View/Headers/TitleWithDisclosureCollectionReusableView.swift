//
//  TitleWithDisclosureCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 14.09.2022.
//

import UIKit

class TitleWithDisclosureCollectionReusableView: UICollectionReusableView {
    //MARK: - Variables
    static let reuseIdentifier = String(describing: TitleWithDisclosureCollectionReusableView.self)
    
    //MARK: - UI
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .title2)
        view.tintColor = C.Colors.Font.main
        return view
    }()
    private let detailButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        view.tintColor = C.Colors.Font.main
        view.contentHorizontalAlignment = .right
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
        addSubview(detailButton)
        let inset = frame.width / 10 / 2
        titleLabel.frame = CGRect(x: inset, y: 0, width: frame.width - 2 * inset - 50, height: frame.height)
        detailButton.frame = CGRect(x: frame.width - 50 - titleLabel.frame.minX, y: 0, width: 50, height: frame.height)
    }
    
    //MARK: - Public func
    func configure(_ title: String) {
        titleLabel.text = title
    }
}

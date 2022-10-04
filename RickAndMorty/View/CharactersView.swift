//
//  CharactersView.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 28.09.2022.
//

import UIKit

protocol CharactersViewOutput {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    func didSelectItemAt(_ indexPath: IndexPath)
}

protocol CharactersViewInput {
    func setAmountCharacters(_ characters: Int, _ amount: Int)
    func setPositionAmountCharactersLabel(_ positionY: CGFloat)
}

class CharactersView: UIView {

    //MARK: - Private variables
    private(set) var collectionView: UICollectionView!
    private(set) lazy var amountCharactersLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = C.Colors.Cell.background
        view.textColor = .black
        view.font = .systemFont(ofSize: 15, weight: .bold)
        view.numberOfLines = 1
        view.textAlignment = .center
        view.layer.cornerRadius = 8.5
        view.clipsToBounds = true
        return view
    }()
    
    //MARK: - Public variables
    var viewOutput: CharactersViewOutput!
    
    //MARK: - Func view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewController()
        createCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private func
    
    private func setupViewController() {
        isUserInteractionEnabled = true
    }
    
    private func createCollectionView() {
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: configureLayout())
        collectionView.delegate = self
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
        addSubview(collectionView)
        collectionView.addSubview(amountCharactersLabel)
        collectionView.backgroundColor = C.Colors.CollectionView.background
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.65))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

//MARK: - UICollectionViewDelegate
extension CharactersView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewOutput.didSelectItemAt(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewOutput.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        UIView.animate(withDuration: 2) {
            self.amountCharactersLabel.alpha = 0
        } completion: { _ in }
    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 2) {
            self.amountCharactersLabel.alpha = 0
        } completion: { _ in }
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        amountCharactersLabel.alpha = 1
        return true
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.2) {
            self.amountCharactersLabel.alpha = 1
        } completion: { _ in }
    }
}

extension CharactersView: CharactersViewInput {
    func setPositionAmountCharactersLabel(_ positionY: CGFloat) {
        amountCharactersLabel.frame = CGRect(x: frame.width - 75, y: positionY, width: 70, height: 20)
    }
    
    func setAmountCharacters(_ characters: Int, _ amount: Int) {
        amountCharactersLabel.text = "\(characters)/\(amount)"
    }
}

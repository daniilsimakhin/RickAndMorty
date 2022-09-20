//
//  View+CreateGradient.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 15.09.2022.
//

import UIKit

extension UIView {
    static func createGradientLayer(_ frame: CGRect) -> UIView {
        let gradientView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        let horizontalGradientLayer: CAGradientLayer = CAGradientLayer()
        horizontalGradientLayer.frame.size = gradientView.frame.size
        horizontalGradientLayer.colors =
        [
            UIColor.black.withAlphaComponent(0.15).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.black.withAlphaComponent(0.15).cgColor,
        ]
        horizontalGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        horizontalGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let verticalGradientLayer: CAGradientLayer = CAGradientLayer()
        verticalGradientLayer.frame.size = gradientView.frame.size
        verticalGradientLayer.colors =
        [
            UIColor.black.withAlphaComponent(0.15).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.black.withAlphaComponent(0.15).cgColor,
        ]
        
        gradientView.layer.addSublayer(horizontalGradientLayer)
        gradientView.layer.addSublayer(verticalGradientLayer)
        return gradientView
    }
}

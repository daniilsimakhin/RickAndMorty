//
//  NavigationController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 04.10.2022.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    private func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = C.Colors.NavBar.background
        appearance.titleTextAttributes = [.foregroundColor: C.Colors.Font.main ?? .white]
        appearance.largeTitleTextAttributes = [.foregroundColor: C.Colors.Font.main  ?? .black]
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}

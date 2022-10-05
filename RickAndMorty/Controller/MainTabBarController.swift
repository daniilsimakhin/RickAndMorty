//
//  MainTabBarController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    //MARK: - View func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    //MARK: - Private func
    private func setupTabBar() {
        setViewControllers([
            createNavigationController(LocationsViewController(), C.Text.Tabbar.locations, C.Images.Tabbar.locations),
            createNavigationController(CharactersViewController(), C.Text.Tabbar.characters, C.Images.Tabbar.characters),
            createNavigationController(EpisodesViewController(), C.Text.Tabbar.episodes, C.Images.Tabbar.episodes),
            createNavigationController(BookmarksViewController(), C.Text.Tabbar.bookmarks, C.Images.Tabbar.bookmarks)
        ], animated: true)
    
        tabBar.backgroundColor = C.Colors.TabBar.background
        tabBar.tintColor = C.Colors.TabBar.tint
        tabBar.barTintColor = C.Colors.TabBar.background
        tabBar.unselectedItemTintColor = C.Colors.TabBar.unselectedItemTint
    }
    
    private func createNavigationController(_ viewController: UIViewController, _ title: String, _ imageName: String) -> UINavigationController {
        let navigationController = NavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: imageName), selectedImage: UIImage(systemName: "\(imageName).fill"))
        return navigationController
    }
}

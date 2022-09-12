//
//  MainTabBarController.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }
    
    func setupTabBar() {
        
        let locationsNavigationViewController = UINavigationController(rootViewController: LocationsViewController())
        let charactersNavigationViewController = UINavigationController(rootViewController: CharactersViewController())
        let episodesNavigationViewController = UINavigationController(rootViewController: EpisodesViewController())
        
        locationsNavigationViewController.tabBarItem = UITabBarItem(title: Constans.Text.Tabbar.locations, image: Constans.Images.Tabbar.locations, tag: 0)
        charactersNavigationViewController.tabBarItem = UITabBarItem(title: Constans.Text.Tabbar.characters, image: Constans.Images.Tabbar.characters, tag: 0)
        episodesNavigationViewController.tabBarItem = UITabBarItem(title: Constans.Text.Tabbar.episodes, image: Constans.Images.Tabbar.episodes, tag: 0)
        
        setViewControllers([locationsNavigationViewController, charactersNavigationViewController, episodesNavigationViewController], animated: true)
        
        tabBar.tintColor = Constans.Colors.Tabbar.tabBarTint
        tabBar.backgroundColor = Constans.Colors.Tabbar.tabBarBackground
        tabBar.unselectedItemTintColor = Constans.Colors.Tabbar.unselectedItemTint
    }
    
}

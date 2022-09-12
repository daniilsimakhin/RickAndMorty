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
        let bookmarksNavigationViewController = UINavigationController(rootViewController: BookmarksViewController())
        
        locationsNavigationViewController.tabBarItem = UITabBarItem(title: Constans.Text.Tabbar.locations, image: Constans.Images.Tabbar.locations, tag: 0)
        charactersNavigationViewController.tabBarItem = UITabBarItem(title: Constans.Text.Tabbar.characters, image: Constans.Images.Tabbar.characters, tag: 1)
        episodesNavigationViewController.tabBarItem = UITabBarItem(title: Constans.Text.Tabbar.episodes, image: Constans.Images.Tabbar.episodes, tag: 2)
        bookmarksNavigationViewController.tabBarItem = UITabBarItem(title: Constans.Text.Tabbar.bookmarks, image: Constans.Images.Tabbar.bookmarks, tag: 3)
        
        setViewControllers([locationsNavigationViewController, charactersNavigationViewController, episodesNavigationViewController, bookmarksNavigationViewController], animated: true)
        
        tabBar.tintColor = Constans.Colors.Tabbar.tabBarTint
        tabBar.backgroundColor = Constans.Colors.Tabbar.tabBarBackground
        tabBar.unselectedItemTintColor = Constans.Colors.Tabbar.unselectedItemTint
    }
    
}

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
        setupTabBar()
    }
    
    func setupTabBar() {
        
        let locationsNavigationViewController = UINavigationController(rootViewController: LocationsViewController())
        let charactersNavigationViewController = UINavigationController(rootViewController: CharactersViewController())
        let episodesNavigationViewController = UINavigationController(rootViewController: EpisodesViewController())
        let bookmarksNavigationViewController = UINavigationController(rootViewController: BookmarksViewController())
        
        locationsNavigationViewController.tabBarItem = UITabBarItem(title: Constans.Text.Tabbar.locations, image: UIImage(systemName: Constans.Images.Tabbar.locations), tag: 0)
        locationsNavigationViewController.tabBarItem.selectedImage = UIImage(systemName: "\(Constans.Images.Tabbar.locations).fill")
        
        charactersNavigationViewController.tabBarItem = UITabBarItem(title: Constans.Text.Tabbar.characters, image: UIImage(systemName: Constans.Images.Tabbar.characters), tag: 1)
        charactersNavigationViewController.tabBarItem.selectedImage = UIImage(systemName: "\(Constans.Images.Tabbar.characters).fill")
        
        episodesNavigationViewController.tabBarItem = UITabBarItem(title: Constans.Text.Tabbar.episodes, image: UIImage(systemName: Constans.Images.Tabbar.episodes), tag: 2)
        episodesNavigationViewController.tabBarItem.selectedImage = UIImage(systemName: "\(Constans.Images.Tabbar.episodes).fill")
        
        bookmarksNavigationViewController.tabBarItem = UITabBarItem(title: Constans.Text.Tabbar.bookmarks, image: UIImage(systemName: Constans.Images.Tabbar.bookmarks), tag: 3)
        bookmarksNavigationViewController.tabBarItem.selectedImage = UIImage(systemName: "\(Constans.Images.Tabbar.bookmarks).fill")
        
        setViewControllers([locationsNavigationViewController, charactersNavigationViewController, episodesNavigationViewController, bookmarksNavigationViewController], animated: true)
        
        tabBar.tintColor = Constans.Colors.Tabbar.tabBarTint
        tabBar.backgroundColor = Constans.Colors.Tabbar.tabBarBackground
        tabBar.unselectedItemTintColor = Constans.Colors.Tabbar.unselectedItemTint
    }
    
}

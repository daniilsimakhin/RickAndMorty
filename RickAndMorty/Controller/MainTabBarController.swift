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
        
        locationsNavigationViewController.tabBarItem = UITabBarItem(title: C.Text.Tabbar.locations, image: UIImage(systemName: C.Images.Tabbar.locations), tag: 0)
        locationsNavigationViewController.tabBarItem.selectedImage = UIImage(systemName: "\(C.Images.Tabbar.locations).fill")
        
        charactersNavigationViewController.tabBarItem = UITabBarItem(title: C.Text.Tabbar.characters, image: UIImage(systemName: C.Images.Tabbar.characters), tag: 1)
        charactersNavigationViewController.tabBarItem.selectedImage = UIImage(systemName: "\(C.Images.Tabbar.characters).fill")
        
        episodesNavigationViewController.tabBarItem = UITabBarItem(title: C.Text.Tabbar.episodes, image: UIImage(systemName: C.Images.Tabbar.episodes), tag: 2)
        episodesNavigationViewController.tabBarItem.selectedImage = UIImage(systemName: "\(C.Images.Tabbar.episodes).fill")
        
        bookmarksNavigationViewController.tabBarItem = UITabBarItem(title: C.Text.Tabbar.bookmarks, image: UIImage(systemName: C.Images.Tabbar.bookmarks), tag: 3)
        bookmarksNavigationViewController.tabBarItem.selectedImage = UIImage(systemName: "\(C.Images.Tabbar.bookmarks).fill")
        
        setViewControllers([locationsNavigationViewController, charactersNavigationViewController, episodesNavigationViewController, bookmarksNavigationViewController], animated: true)
        
        tabBar.tintColor = C.Colors.Tabbar.tabBarTint
        tabBar.backgroundColor = C.Colors.Tabbar.tabBarBackground
        tabBar.unselectedItemTintColor = C.Colors.Tabbar.unselectedItemTint
    }
    
}

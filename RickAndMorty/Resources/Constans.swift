//
//  Constans.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import Foundation
import UIKit

typealias C = Constans
enum Constans {
    enum Colors {
        enum TabBar {
            static let unselectedItemTint = UIColor(named: "tabBarUnselectedItemTint")
            static let background = UIColor(named: "tabBarBackground")
            static let tint = UIColor(named: "tabBarTint")
        }
        
        enum NavBar {
            static let background = UIColor(named: "navBarBackground")
            static let item = UIColor(named: "navBarButton")
        }
        
        enum Cell {
            static let background = UIColor(named: "cellBackground")
        }
        
        enum CollectionView {
            static let background = UIColor(named: "collectionViewBackground")
        }
        
        enum Font {
            static let main = UIColor(named: "fontMain")
            static let secondary = UIColor(named: "fontSecondary")
        }
    }

    enum Text {
        enum Tabbar {
            static let locations = "Locations"
            static let characters = "Characters"
            static let episodes = "Episodes"
            static let bookmarks = "Bookmarks"
        }
        
        enum Titles {
            static let locations = "Locations"
            static let characters = "Characters"
            static let episodes = "Episodes"
            static let bookmarks = "Bookmarks"
        }
    }

    enum Images {
        enum Tabbar {
            static let locations = "globe.asia.australia"
            static let characters = "person.2.circle"
            static let episodes = "play.circle"
            static let bookmarks = "bookmark.circle"
        }
        
        enum NavBar {
            enum EpisodesView {
                static let rightBarButton = "arrow.right.circle"
                static let leftBarButton = "arrow.left.circle"
            }
        }
    }
}

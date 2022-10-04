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
        enum Tabbar {
            static let unselectedItemTint = UIColor(named: "unselectedItemTint")
            static let tabBarBackground = UIColor(named: "tabBarBackground")
            static let tabBarTint = UIColor(named: "tabBarTint")
        }
        
        enum Cell {
            static let background = UIColor(named: "cellBackground")
        }
        
        enum CollectionView {
            static let background = UIColor(named: "collectionViewBackground")
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

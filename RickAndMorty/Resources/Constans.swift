//
//  Constans.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 12.09.2022.
//

import Foundation
import UIKit

struct Constans {
    struct Colors {
        struct Tabbar {
            static let unselectedItemTint = UIColor(named: "unselectedItemTint")
            static let tabBarBackground = UIColor(named: "tabBarBackground")
            static let tabBarTint = UIColor(named: "tabBarTint")
        }
    }

    struct Text {
        struct Tabbar {
            static let locations = "Locations"
            static let characters = "Characters"
            static let episodes = "Episodes"
            static let bookmarks = "Bookmarks"
        }
        
        struct Titles {
            static let locations = "Locations"
            static let characters = "Characters"
            static let episodes = "Episodes"
            static let bookmarks = "Bookmarks"
        }
    }

    struct Images {
        struct Tabbar {
            static let locations = "globe.asia.australia"
            static let characters = "person.2.circle"
            static let episodes = "play.circle"
            static let bookmarks = "bookmark.circle"
        }
    }
}

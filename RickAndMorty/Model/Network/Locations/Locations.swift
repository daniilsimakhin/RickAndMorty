//
//  Locations.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 21.09.2022.
//

import Foundation

struct Locations: Decodable {
    let info: PageInfo
    let results: [Location]
}

//
//  Episodes.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 23.09.2022.
//

import Foundation

struct Episodes: Decodable {
    let info: PageInfo
    let results: [Episode]
}

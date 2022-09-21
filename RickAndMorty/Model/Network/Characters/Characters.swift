//
//  Characters.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 21.09.2022.
//

import Foundation

struct Characters: Decodable {
    let info: PageInfo
    let results: [Character]
}

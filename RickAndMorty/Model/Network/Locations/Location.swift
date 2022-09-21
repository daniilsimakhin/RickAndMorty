//
//  Location.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 21.09.2022.
//

import Foundation

struct Location: Decodable, Hashable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

//
//  Episode.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 23.09.2022.
//

import Foundation

struct Episode: Decodable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}

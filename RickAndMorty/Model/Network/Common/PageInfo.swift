//
//  PageInfo.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 21.09.2022.
//

import Foundation

struct PageInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

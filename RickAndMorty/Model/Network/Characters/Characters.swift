//
//  Characters.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 21.09.2022.
//

import Foundation

struct Characters: Decodable {
    let info: PageInfo
    var results: [Character]
    #warning("@ToDo: Вернуть иммутабельность структурке")
}

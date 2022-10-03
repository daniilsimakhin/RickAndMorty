//
//  DetailInfo.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 01.10.2022.
//

import UIKit

enum DetailInfo {
    case getLocation(location: Location)
    case getCharacter(character: Character)
    case getEpisode(episode: Episode)
    
    var title: String {
        switch self {
        case .getLocation:
            return "Location"
        case .getCharacter:
            return "Character"
        case .getEpisode:
            return "Episode"
        }
    }
    
    var image: String? {
        switch self {
        case .getCharacter(let character):
            return character.image
        case .getEpisode, .getLocation:
            return nil
        }
    }
    
    var information: [String] {
        switch self {
        case .getLocation(let location):
            return [location.type, location.name, location.dimension]
        case .getCharacter(let character):
            return [character.status, character.name, character.species]
        case .getEpisode(let episode):
            return [episode.air_date, episode.name, episode.episode]
        }
    }
    
    var additionalInformation: [String]? {
        switch self {
        case .getCharacter(let character):
            return [character.gender, character.origin.name, character.type == "" ? "Unknown" : character.type, character.location.name]
        case .getEpisode, .getLocation:
            return nil
        }
    }
    
    var characters: [String]? {
        switch self {
        case .getLocation(let location):
            return location.residents
        case .getCharacter(_):
            return nil
        case .getEpisode(let episode):
            return episode.characters
        }
    }
    
    var episodes: [String]? {
        switch self {
        case .getLocation, .getEpisode:
            return nil
        case .getCharacter(let character):
            return character.episode
        }
    }
}

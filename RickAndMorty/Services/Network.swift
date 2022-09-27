//
//  Network.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 23.09.2022.
//

import Foundation

enum Router {
    case getLocations(page: Int)
    case getCharacters(page: Int)
    case getEpisodes(page: Int)
    case getMultipleEpisodes(members: [String])

    var page: Int {
        switch self {
        case .getLocations(let page):
            return page
        case .getCharacters(let page):
            return page
        case .getEpisodes(let page):
            return page
        case .getMultipleEpisodes:
            return 0
        }
    }
    
    var members: String {
        switch self {
        case .getLocations, .getCharacters, .getEpisodes:
            return ""
        case .getMultipleEpisodes(let members):
            return members.joined(separator: ",")
        }
    }
    
    var scheme: String {
        switch self {
        case .getLocations, .getCharacters, .getEpisodes, .getMultipleEpisodes:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getLocations, .getCharacters, .getEpisodes, .getMultipleEpisodes:
            return "rickandmortyapi.com"
        }
    }
    
    var path: String {
        switch self {
        case .getLocations:
            return "/api/location"
        case .getCharacters:
            return "/api/character"
        case .getEpisodes:
            return "/api/episode"
        case .getMultipleEpisodes:
            return "/api/episode/\(members)"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getLocations, .getCharacters, .getEpisodes:
            return [URLQueryItem(name: "page", value: "\(page)")]
        case .getMultipleEpisodes:
            return []
        }
    }
    
    var method: String {
        switch self {
        case .getLocations, .getCharacters, .getEpisodes, .getMultipleEpisodes:
            return "GET"
        }
    }
}

class ServiceLayer {
    
    static var pagination = false
    
    class func request<T: Decodable>(router: Router, completion: @escaping (Result<T, Error>) -> ()) {
        pagination = true
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        print(components.url?.absoluteString)
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            let responseObject = try! JSONDecoder().decode(T.self, from: data)
            
            completion(.success(responseObject))
            pagination = false
        }
        dataTask.resume()
    }
}

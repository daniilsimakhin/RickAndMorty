//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Даниил Симахин on 21.09.2022.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    enum APIError: Error {
        case failureToGetData
    }
    
    let baseUrl = "https://rickandmortyapi.com/api"
    
    func getCharacters(completion: @escaping (Result<Characters, Error>) -> Void) {
        guard let url = URL(string: baseUrl + "/character/?page=2") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let safeData = data else {
                completion(.failure(APIError.failureToGetData))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(Characters.self, from: safeData)
                DispatchQueue.main.sync {
                    completion(.success(decodedData))
                }
            } catch {
                print("Error with get characters")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getLocations(completion: @escaping (Result<Locations, Error>) -> Void) {
        guard let url = URL(string: baseUrl + "/location?page=3") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let safeData = data else {
                completion(.failure(APIError.failureToGetData))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(Locations.self, from: safeData)
                DispatchQueue.main.sync {
                    completion(.success(decodedData))
                }
            } catch {
                print("Erro with get locations")
                completion(.failure(APIError.failureToGetData))
            }
        }.resume()
    }
}

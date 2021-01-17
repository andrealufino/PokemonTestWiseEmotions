//
//  APIManager.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 13/01/21.
//

import Foundation


struct APIManager {
    
    private static let baseURL = "https://pokeapi.co/api/v2/"
    
    
    // MARK: Methods
    
    /// Call the web service to get the list of pokémon. 
    /// - Parameters:
    ///   - limit: The number of element per page.
    ///   - offset: The number of element to leave out for this call. For example, starting from 150 the first Pokémon will be Mew, the number 151.
    ///   - completion: The completion block, with a `Result`.
    static func list(limit: Int = 20, offset: Int = 0, completion: @escaping (Result<[Pokemon], APIError>) -> Void) {
        
        guard Reachability().isConnectedToNetwork() else {
            completion(.failure(APIError.noInternetConnection))
            return
        }
        
        let url = baseURL + "pokemon?limit=\(limit)&offset=\(offset)"
        
        URLSession.shared.dataTask(with: URL.init(string: url)!) {(data, response, error) in
            
            guard error == nil else {
                completion(.failure(APIError.serverError.attach(debugMessage: error!.localizedDescription)))
                return
            }
            
            switch Parser.pokemonFromList(data: data!) {
            case .success(let pokemon):
                completion(.success(pokemon))
            case .failure(let error):
                completion(.failure(APIError.generic.attach(debugMessage: error.localizedDescription)))
            }
            
        }.resume()
    }
    
    /// Call this web service to get the details of a specific pokémon.
    /// - Parameters:
    ///   - name: The name of the pokémon.
    ///   - completion: The completion block, with a `Result`.
    static func details(forPokemonWithName name: String, completion: @escaping (Result<Pokemon, APIError>) -> Void) {
        
        guard Reachability().isConnectedToNetwork() else {
            completion(.failure(APIError.noInternetConnection))
            return
        }
        
        let url = baseURL + "pokemon/\(name)"
        
        URLSession.shared.dataTask(with: URL.init(string: url)!) {(data, response, error) in
            
            guard error == nil else {
                completion(.failure(APIError.generic))
                return
            }
            
            do {
                let pokemon = try JSONDecoder.init().decode(Pokemon.self, from: data!)
                
                completion(.success(pokemon))
                
            } catch (let error) {
                completion(.failure(APIError.serverError.attach(debugMessage: error.localizedDescription)))
            }
        }.resume()
    }
}

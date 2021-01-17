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
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                let rawArray = json!["results"] as! Array<Dictionary<String, Any>>
                var pokemon = [Pokemon]()
                rawArray.forEach { (element) in
                    let aPokemon = Pokemon()
                    aPokemon.identifier = Int(((element["url"] as? String)?.dropLast().components(separatedBy: "/").last)!)
                    aPokemon.name = element["name"] as? String
                    pokemon.append(aPokemon)
                }
                
                completion(.success(pokemon))
                
            } catch (let error) {
                completion(.failure(APIError.serverError.attach(debugMessage: error.localizedDescription)))
            }
            
        }.resume()
    }
    
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

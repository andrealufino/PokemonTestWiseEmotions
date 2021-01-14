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
    
    static func list(limit: Int? = nil, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        
        var url = baseURL + "pokemon"
        if let aLimit = limit {
            url += "?limit=\(aLimit)"
        }
        
        URLSession.shared.dataTask(with: URL.init(string: url)!) {(data, response, error) in
            
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                let rawArray = json!["results"] as! Array<Dictionary<String, Any>>
                var pokemon = [Pokemon]()
                rawArray.forEach { (element) in
                    let aPokemon = Pokemon()
                    aPokemon.identifier = Int(((element["url"] as? String)?.dropLast().components(separatedBy: "/").last)!)
                    aPokemon.name = (element["name"] as? String)?.capitalized
                    pokemon.append(aPokemon)
                }
                
                completion(.success(pokemon))
                
            } catch (let error) {
                print("Error during serialization.")
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    static func details(forPokemonWithName name: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        
        let url = baseURL + "pokemon/\(name)"
        
        URLSession.shared.dataTask(with: URL.init(string: url)!) {(data, response, error) in
            
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let pokemon = try JSONDecoder.init().decode(Pokemon.self, from: data!)
                
                completion(.success(pokemon))
                
            } catch (let error) {
                print("Error during serialization. Details: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}

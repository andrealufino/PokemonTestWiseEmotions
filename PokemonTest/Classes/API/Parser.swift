//
//  Parser.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 17/01/21.
//

import Foundation


/// Parse the result of the API.
class Parser {
    
    /// Parse the result of a web call to the service to get the list of pokemon.
    /// - Parameter data: The result of the call.
    /// - Returns: `Result` with an array of `Pokemon` for the success and an `Error` for the failure.
    static func pokemonFromList(data: Data) -> Result<[Pokemon], Error> {
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            let rawArray = json!["results"] as! Array<Dictionary<String, Any>>
            var pokemon = [Pokemon]()
            rawArray.forEach { (element) in
                let aPokemon = Pokemon()
                aPokemon.identifier = Int(((element["url"] as? String)?.dropLast().components(separatedBy: "/").last)!)
                aPokemon.name = element["name"] as? String
                pokemon.append(aPokemon)
            }
            
            return .success(pokemon)
        } catch (let error) {
            return .failure(error)
        }
    }
}

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
    
    /// Parse the result of a web call to the service to get the details of a pokémon.
    /// - Parameter data: The result of the call.
    /// - Returns: `Result` with a `Pokemon` object for the success and an `Error` for the failure.
    static func pokemonDetails(_ data: Data) -> Result<Pokemon, Error> {
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            let pokemon = Pokemon.init()
            let rawTypes = json!["types"] as! Array<Dictionary<String, Any>>
            var types = [Type]()
            rawTypes.forEach { (element) in
                let type = Type.init()
                type.name = ((element["type"] as! [String: Any])["name"] as! String)
                types.append(type)
            }
            let rawStats = json!["stats"] as! Array<Dictionary<String, Any>>
            var stats = [Statistic]()
            rawStats.forEach { (element) in
                let stat = Statistic.init()
                stat.name = ((element["stat"] as! [String: Any])["name"] as! String)
                stat.value = (element["base_stat"] as! Int)
                stats.append(stat)
            }
            pokemon.types = types
            pokemon.stats = stats
            pokemon.identifier = (json!["id"] as! Int)
            pokemon.name = (json!["name"] as! String)
            
            return .success(pokemon)
        } catch (let error) {
            
            return .failure(error)
        }
    }
}

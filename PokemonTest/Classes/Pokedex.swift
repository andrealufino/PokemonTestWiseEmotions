//
//  Pokedex.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 13/01/21.
//

import Foundation


class Pokedex {
    
    static var shared = Pokedex.init()
    
    private var pokemonSet: Set<Pokemon>?
    
    var pokemon: [Pokemon] {
        return Array(pokemonSet!)
    }
    
    private init() {
        pokemonSet = []
    }
}

extension Pokedex {
    
    func add(_ pokemon: [Pokemon]) {
        
        self.pokemonSet?.formUnion(pokemon)
    }
    
    @discardableResult
    func update(_ pokemon: Pokemon) -> Bool {
        
        if var aPokemon = self.pokemonSet!.first(where: {$0.name == pokemon.name }) {
            aPokemon = pokemon
            return true
        }
        
        return false
    }
}

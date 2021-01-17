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
        return Array(pokemonSet!).sorted { (left, right) -> Bool in
            return left.identifier! < right.identifier!
        }
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
        
        return (pokemonSet?.update(with: pokemon) != nil) ? true : false
    }
    
    func get(pokemonWithIdentifier identifier: Int) -> Pokemon? {
        
        return pokemonSet?.first(where: { (pokemon) -> Bool in
            return pokemon.identifier! == identifier
        })
    }
}

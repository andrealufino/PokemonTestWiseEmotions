//
//  PokemonDetailsViewModel.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 14/01/21.
//

import Foundation


// MARK: - PokemonDetailViewModel - Delegate

protocol PokemonDetailsViewModelDelegate: AnyObject {
    func pokemonDetailsViewModelDidStartFetching(_ viewModel: PokemonDetailsViewModel)
    func pokemonDetailsViewModelDidFinishFetching(_ viewModel: PokemonDetailsViewModel)
    func pokemonDetailsViewModel(_ viewModel: PokemonDetailsViewModel, didFinishFetchingWithError error: APIError)
    func pokemonDetailsViewModelDidFinishFetchingWithSuccess(_ viewModel: PokemonDetailsViewModel)
    func pokemonDetailsViewModel(_ viewModel: PokemonDetailsViewModel, didFinishFetchingWithSuccess pokemon: Pokemon)
}


// MARK: - PokemonDetailsViewModel

class PokemonDetailsViewModel {
    
    weak var delegate: PokemonDetailsViewModelDelegate?
    
    var pokemon: Pokemon?
    
    init() {
        setup()
    }
    
    init(withDelegate delegate: PokemonDetailsViewModelDelegate) {
        setup()
        self.delegate = delegate
    }
    
    private func setup() {
        
    }
}


// MARK: - Fetching

extension PokemonDetailsViewModel {
    
    func fetchPokemonDetails(withIdentifier identifier: Int) {
        
        APIManager.details(forPokemonWithIdentifier: identifier) { (result) in
            self.delegate?.pokemonDetailsViewModelDidFinishFetching(self)
            switch result {
            case .success(let pokemon):
                Pokedex.shared.update(pokemon)
                self.pokemon = Pokedex.shared.get(pokemonWithIdentifier: pokemon.identifier!)
                self.delegate?.pokemonDetailsViewModelDidFinishFetchingWithSuccess(self)
                self.delegate?.pokemonDetailsViewModel(self, didFinishFetchingWithSuccess: Pokedex.shared.get(pokemonWithIdentifier: pokemon.identifier!)!)
            case .failure(let error):
                self.delegate?.pokemonDetailsViewModel(self, didFinishFetchingWithError: error)
            }
        }
    }
}


// MARK: - Cell Identifiers

extension PokemonDetailsViewModel {
    
    struct CellIdentifiers {
        static let pokemonDetails           = "pokemonDetailsCell"
    }
}

//
//  PokemonDetailsViewModel.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 14/01/21.
//

import Foundation


// MARK: - PokemonDetailViewModel - Delegate

/// The delegate to get the callbacks to visually fill the details of the pokémon.
protocol PokemonDetailsViewModelDelegate: AnyObject {
    /// Called when the fetching starts.
    /// - Parameter viewModel: The view model that calls the method.
    func pokemonDetailsViewModelDidStartFetching(_ viewModel: PokemonDetailsViewModel)
    /// Called when the fetching finishes.
    /// - Parameter viewModel: The view model that calls the method.
    func pokemonDetailsViewModelDidFinishFetching(_ viewModel: PokemonDetailsViewModel)
    /// Called when the fetching finishes with an error.
    /// - Parameters:
    ///   - viewModel: The view model that calls the method.
    ///   - error: The error that occurred.
    func pokemonDetailsViewModel(_ viewModel: PokemonDetailsViewModel, didFinishFetchingWithError error: APIError)
    /// Called when the fetching finishes with success.
    /// - Parameter viewModel: The view model that calls the method.
    func pokemonDetailsViewModelDidFinishFetchingWithSuccess(_ viewModel: PokemonDetailsViewModel)
    /// Called when the fetching finishes with success.
    /// - Parameters:
    ///   - viewModel: The view model that calls the method.
    ///   - pokemon: The `Pokemon` object.
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
    
    /// Start fetching the details for the pokémon with the passed identifier..
    /// - Parameter identifier: The identifier of the pokémon.
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

//
//  PokemonListViewModel.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 14/01/21.
//

import Foundation


// MARK: - PokemonListViewModel - Delegate

/// The delegate to get the callbacks to visually fill the list of pokémon.
protocol PokemonListViewModelDelegate: AnyObject {
    /// Called when the fetching starts
    /// - Parameter viewModel: The view model that calls the method.
    func pokemonListViewModelDidStartFetching(_ viewModel: PokemonListViewModel)
    /// Called when the fetching is finished
    /// - Parameter viewModel: The view model that calls the method.
    func pokemonListViewModelDidFinishFetching(_ viewModel: PokemonListViewModel)
    /// Called when the fetching finishes with an error.
    /// - Parameters:
    ///   - viewModel: The view model that calls the method.
    ///   - error: The error that occurred.
    func pokemonListViewModel(_ viewModel: PokemonListViewModel, didFinishFetchingWithError error: APIError)
    /// Called when the fetching finishes with success.
    /// - Parameter viewModel: The view model that calls the method.
    func pokemonListViewModelDidFinishFetchingWithSuccess(_ viewModel: PokemonListViewModel)
    /// Called when the fetching finishes with success.
    /// - Parameters:
    ///   - viewModel: The view model that calls the method.
    ///   - pokemon: The array of pokémon.
    func pokemonListViewModel(_ viewModel: PokemonListViewModel, didFinishFetchingWithSuccess pokemon: [Pokemon])
    /// Called when there are no more pokémon to load.
    /// - Parameter viewModel: The view model that calls the method.
    func pokemonListViewModelNoMorePokemonToLoad(_ viewModel: PokemonListViewModel)
}


// MARK: - PokemonListViewModel

class PokemonListViewModel {
    
    weak var delegate: PokemonListViewModelDelegate?
    
    private var page = 0
    private let limit = 100
    private var isPokedexFull = false
    
    var pokemon: [Pokemon] {
        return Pokedex.shared.pokemon
    }
    
    init() {
        setup()
    }
    
    init(withDelegate delegate: PokemonListViewModelDelegate) {
        setup()
        self.delegate = delegate
    }
    
    private func setup() {
        
    }
}


// MARK: - Fetching

extension PokemonListViewModel {
    
    /// Start fetching the pokémon.
    func fetchPokemon() {
        
        guard !isPokedexFull else {
            delegate?.pokemonListViewModelNoMorePokemonToLoad(self)
            return
        }
        
        delegate?.pokemonListViewModelDidStartFetching(self)
        
        APIManager.list(limit: limit, offset: limit * page) { (result) in
            
            self.delegate?.pokemonListViewModelDidFinishFetching(self)
            
            switch result {
            case .success(let pokemon):
                if pokemon.count < self.limit {
                    // We reached the end of the list
                    self.isPokedexFull = true
                } else {
                    self.page += 1
                }
                Pokedex.shared.add(pokemon)
                self.delegate?.pokemonListViewModelDidFinishFetchingWithSuccess(self)
                self.delegate?.pokemonListViewModel(self, didFinishFetchingWithSuccess: Pokedex.shared.pokemon)
            case .failure(let error):
                self.delegate?.pokemonListViewModel(self, didFinishFetchingWithError: error)
            }
        }
    }
}


// MARK: - Cell Identifiers

extension PokemonListViewModel {
    
    struct CellIdentifiers {
        static let pokemonList          = "pokemonListCellIdentifier"
    }
}

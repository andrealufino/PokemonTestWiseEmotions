//
//  PokemonListViewModel.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 14/01/21.
//

import Foundation


// MARK: - PokemonListViewModel - Delegate

protocol PokemonListViewModelDelegate: AnyObject {
    func pokemonListViewModelDidStartFetching(_ viewModel: PokemonListViewModel)
    func pokemonListViewModelDidFinishFetching(_ viewModel: PokemonListViewModel)
    func pokemonListViewModel(_ viewModel: PokemonListViewModel, didFinishFetchingWithError error: APIError)
    func pokemonListViewModelDidFinishFetchingWithSuccess(_ viewModel: PokemonListViewModel)
    func pokemonListViewModel(_ viewModel: PokemonListViewModel, didFinishFetchingWithSuccess pokemon: [Pokemon])
    func pokemonListViewModelNoMorePokemonToLoad(_ viewModel: PokemonListViewModel)
}


// MARK: - PokemonListViewModel

class PokemonListViewModel {
    
    weak var delegate: PokemonListViewModelDelegate?
    
    private var page = 0
    private let limit = 100
    private var isPokedexFull = false
    
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
                self.delegate?.pokemonListViewModelDidFinishFetchingWithSuccess(self)
                self.delegate?.pokemonListViewModel(self, didFinishFetchingWithSuccess: pokemon)
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

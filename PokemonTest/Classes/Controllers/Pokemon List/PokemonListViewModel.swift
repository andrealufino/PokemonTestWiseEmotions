//
//  PokemonListViewModel.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 14/01/21.
//

import Foundation


protocol PokemonListViewModelDelegate: AnyObject {
    func pokemonListViewModelDidStartFetching(_ viewModel: PokemonListViewModel)
    func pokemonListViewModelDidFinishFetching(_ viewModel: PokemonListViewModel)
    func pokemonListViewModel(_ viewModel: PokemonListViewModel, didFinishFetchingWithError error: Error)
    func pokemonListViewModelDidFinishFetchingWithSuccess(_ viewModel: PokemonListViewModel)
    func pokemonListViewModel(_ viewModel: PokemonListViewModel, didFinishFetchingWithSuccess pokemon: [Pokemon])
}

class PokemonListViewModel {
    
    weak var delegate: PokemonListViewModelDelegate?
    
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


extension PokemonListViewModel {
    
    func fetchPokemon() {
        
        delegate?.pokemonListViewModelDidStartFetching(self)
        
        APIManager.list { (result) in
            switch result {
            case .success(let pokemon):
                self.delegate?.pokemonListViewModelDidFinishFetchingWithSuccess(self)
                self.delegate?.pokemonListViewModel(self, didFinishFetchingWithSuccess: pokemon)
            case .failure(let error):
                self.delegate?.pokemonListViewModel(self, didFinishFetchingWithError: error)
            }
        }
    }
}


extension PokemonListViewModel {
    
    struct CellIdentifiers {
        static let pokemonList          = "pokemonListCellIdentifier"
    }
}

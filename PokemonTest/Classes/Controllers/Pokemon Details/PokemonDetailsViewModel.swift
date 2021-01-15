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
    func pokemonDetailsViewModel(_ viewModel: PokemonDetailsViewModel, didFinishFetchingWithError error: Error)
    func pokemonDetailsViewModelDidFinishFetchingWithSuccess(_ viewModel: PokemonDetailsViewModel)
    func pokemonDetailsViewModel(_ viewModel: PokemonDetailsViewModel, didFinishFetchingWithSuccess pokemon: Pokemon)
}


// MARK: - PokemonDetailsViewModel

class PokemonDetailsViewModel {
    
    weak var delegate: PokemonDetailsViewModelDelegate?
    
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

extension PokemonDetailsViewModel {
    
    func fetchPokemonDetails(_ pokemon: Pokemon) {
        
        APIManager.details(forPokemonWithName: pokemon.name!) { (result) in
            self.delegate?.pokemonDetailsViewModelDidFinishFetching(self)
            switch result {
            case .success(let pokemon):
                self.delegate?.pokemonDetailsViewModelDidFinishFetchingWithSuccess(self)
                self.delegate?.pokemonDetailsViewModel(self, didFinishFetchingWithSuccess: pokemon)
                break
            case .failure(let error):
                self.delegate?.pokemonDetailsViewModel(self, didFinishFetchingWithError: error)
                break
            }
        }
    }
}

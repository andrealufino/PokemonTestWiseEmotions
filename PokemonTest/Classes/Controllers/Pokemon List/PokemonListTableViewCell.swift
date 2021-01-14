//
//  PokemonListTableViewCell.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 14/01/21.
//

import Foundation
import UIKit

// MARK: - Instance vars and IBOutlets

class PokemonListTableViewCell: UITableViewCell {
    
    var pokemonImage: UIImageView!
    var lblName: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        pokemonImage = UIImageView.init()
        pokemonImage.backgroundColor = .clear
        addSubview(pokemonImage)
        
        lblName = UILabel.init()
        lblName.font = UIFont.boldSystemFont(ofSize: 24)
        lblName.numberOfLines = 2
        lblName.backgroundColor = .clear
        addSubview(lblName)
        
        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        lblName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokemonImage.leadingAnchor.constraint(equalTo: pokemonImage.superview!.leadingAnchor, constant: 10),
            pokemonImage.topAnchor.constraint(equalTo: pokemonImage.superview!.topAnchor, constant: 10),
            pokemonImage.bottomAnchor.constraint(equalTo: pokemonImage.superview!.bottomAnchor, constant: -10),
            pokemonImage.widthAnchor.constraint(equalToConstant: 80),
            lblName.topAnchor.constraint(equalTo: pokemonImage.topAnchor),
            lblName.bottomAnchor.constraint(equalTo: pokemonImage.bottomAnchor),
            lblName.leadingAnchor.constraint(equalTo: pokemonImage.trailingAnchor, constant: 40),
            lblName.trailingAnchor.constraint(equalTo: lblName.superview!.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: -

extension PokemonListTableViewCell {
    
    func activateColorSplash() {
        let color = pokemonImage.image?.averageColor()
        
        backgroundColor = color
    }
}

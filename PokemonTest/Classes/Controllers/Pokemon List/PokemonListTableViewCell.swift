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
    
    var pokemonImageView: UIImageView!
    var lblName: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        pokemonImageView = UIImageView.init()
        pokemonImageView.backgroundColor = .clear
        addSubview(pokemonImageView)
        
        lblName = UILabel.init()
        lblName.font = UIFont.boldSystemFont(ofSize: 24)
        lblName.numberOfLines = 2
        lblName.backgroundColor = .clear
        addSubview(lblName)
        
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        lblName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokemonImageView.leadingAnchor.constraint(equalTo: pokemonImageView.superview!.leadingAnchor, constant: 10),
            pokemonImageView.topAnchor.constraint(equalTo: pokemonImageView.superview!.topAnchor, constant: 10),
            pokemonImageView.bottomAnchor.constraint(equalTo: pokemonImageView.superview!.bottomAnchor, constant: -10),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 80),
            lblName.topAnchor.constraint(equalTo: pokemonImageView.topAnchor),
            lblName.bottomAnchor.constraint(equalTo: pokemonImageView.bottomAnchor),
            lblName.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 40),
            lblName.trailingAnchor.constraint(equalTo: lblName.superview!.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

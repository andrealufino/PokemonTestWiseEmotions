//
//  PokemonDetailsStatsTableViewCell.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 15/01/21.
//

import Foundation
import UIKit


// MARK: - Instance vars and IBOutlets

class PokemonDetailsStatsTableViewCell: UITableViewCell {
    
    var lblTitle: UILabel!
    var lblValue: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        lblTitle = UILabel.init()
        lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
        lblTitle.minimumScaleFactor = 0.6
        addSubview(lblTitle)
        
        lblValue = UILabel.init()
        lblValue.font = UIFont.italicSystemFont(ofSize: 18)
        lblValue.textAlignment = .right
        addSubview(lblValue)
        
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblValue.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: lblTitle.superview!.topAnchor, constant: 10),
            lblTitle.leadingAnchor.constraint(equalTo: lblTitle.superview!.leadingAnchor, constant: 10),
            lblTitle.bottomAnchor.constraint(equalTo: lblTitle.superview!.bottomAnchor, constant: -10),
            lblTitle.widthAnchor.constraint(equalTo: lblTitle.superview!.widthAnchor, multiplier: 0.7),
            lblValue.topAnchor.constraint(equalTo: lblTitle.topAnchor),
            lblValue.leadingAnchor.constraint(equalTo: lblTitle.trailingAnchor, constant: 20),
            lblValue.trailingAnchor.constraint(equalTo: lblValue.superview!.trailingAnchor, constant: -10),
            lblValue.bottomAnchor.constraint(equalTo: lblTitle.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

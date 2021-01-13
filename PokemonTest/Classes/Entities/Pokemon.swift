//
//  Pokemon.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 13/01/21.
//

import Foundation


class Pokemon: Decodable {
    
    var identifier: Int?
    
    var name: String?
    var imageURL: String?
    
    var types: [Type]?
    var stats: [Statistic]?
    
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        types = try values.decode([Type].self, forKey: .types)
        stats = try values.decode([Statistic].self, forKey: .stats)
        
        let images = try values.nestedContainer(keyedBy: AdditonalInfoCodingKeys.self, forKey: .images)
        let other = try images.nestedContainer(keyedBy: AdditonalInfoCodingKeys.self, forKey: .other)
        let officialArtwork = try other.nestedContainer(keyedBy: AdditonalInfoCodingKeys.self, forKey: .officialArtwork)
        imageURL = try officialArtwork.decode(String.self, forKey: .front)
    }
    
    private enum CodingKeys: String, CodingKey {
        case identifier         = "id"
        case name               = "name"
        case types              = "types"
        case stats              = "stats"
        case images             = "sprites"
    }
    
    private enum AdditonalInfoCodingKeys: String, CodingKey {
        case other
        case officialArtwork        = "official-artwork"
        case front                  = "front_default"
    }
}


extension Pokemon: Equatable {
    
    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name
    }
}


extension Pokemon: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

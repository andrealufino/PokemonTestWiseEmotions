//
//  Type.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 13/01/21.
//

import Foundation


class Type: Decodable {
    
    var name: String?
    var iconURL: String?
    
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let type = try values.decode(Dictionary<String, String>.self, forKey: .type)
        name = type["name"]
        iconURL = type["url"]
    }
    
    private enum CodingKeys: String, CodingKey {
        case type           = "type"
    }
}

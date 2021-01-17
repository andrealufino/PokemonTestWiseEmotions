//
//  Statistic.swift
//  PokemonTest
//
//  Created by Andrea Mario Lufino on 13/01/21.
//

import Foundation


class Statistic: Decodable {
    
    var name: String?
    var value: Int?
    var detailURL: String?
    
    init() { }
    
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let stat = try values.decode(Dictionary<String, String>.self, forKey: .stat)
        value = try values.decode(Int.self, forKey: .value)
        name = stat["name"]
        detailURL = stat["url"]
    }
    
    private enum CodingKeys: String, CodingKey {
        case value      = "base_stat"
        
        case stat       = "stat"
    }
}

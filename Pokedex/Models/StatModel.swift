//
//  StatModel.swift
//  Pokedex
//
//  Created by Emeric SAUTHIER on 2/24/25.
//

import Foundation

struct PokemonStat: Codable, Identifiable {
    var base_stat: Int
    var effort: Int
    var stat: PokemonStatInfo
    
    var id: String { name }
    var name: String { stat.name }
}

struct PokemonStatInfo: Codable {
    var name: String
}

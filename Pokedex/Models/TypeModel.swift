//
//  TypeModel.swift
//  Pokedex
//
//  Created by Emeric SAUTHIER on 2/17/25.
//

import Foundation

struct PokemonTypeInfo: Codable {
    var type: PokemonType
}

struct PokemonType: Codable {
    var name: String
}

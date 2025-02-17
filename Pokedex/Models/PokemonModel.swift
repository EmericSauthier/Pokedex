//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Emeric SAUTHIER on 2/17/25.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    var id: Int
    var name: String
    var types: [PokemonTypeInfo]
    var sprites: PokemonSprite
}

struct PokemonInfoResponse: Codable {
    var results: [PokemonInfo]
}

struct PokemonInfo: Codable {
    var name: String
    var url: String
}

//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Emeric SAUTHIER on 2/17/25.
//

import Foundation
import SwiftUI

struct Pokemon: Codable, Identifiable {
    var id: Int
    var name: String
    var types: [PokemonType]
    var sprites: PokemonSprite
    var stats: [PokemonStat]
    
    // Pokemon's stats
    var hp: Int { stats.filter( { $0.name == "hp" }).first?.base_stat ?? 0 }
    var attack: Int { stats.filter( { $0.name == "attack" }).first?.base_stat ?? 0 }
    var defense: Int { stats.filter( { $0.name == "defense" }).first?.base_stat ?? 0 }
    var speed: Int { stats.filter( { $0.name == "speed" }).first?.base_stat ?? 0 }
    
    static func toString(pokemon: Pokemon) -> String {
        do {
            return try JSONEncoder().encode(pokemon).base64EncodedString()
        } catch {
            print("Erreur : \(error)")
            return ""
        }
    }
    
    static func toJson(stringObject: String) -> Pokemon? {
        if stringObject.isEmpty { return nil }
        
        do {
            return try JSONDecoder().decode(Pokemon.self, from: stringObject.data(using: .utf8)!)
        } catch {
            print("Erreur : \(error)")
            return nil
        }
    }
    
    func getTypes() -> String {
        var string = " "
        
        for type in types {
            string += "\(type.name)  "
        }
        string += " "
        return string.replacingOccurrences(of: "   ", with: "").replacingOccurrences(of: "  ", with: ", ")
    }
}

struct PokemonInfoResponse: Codable {
    var results: [PokemonInfo]
}

struct PokemonInfo: Codable {
    var name: String
    var url: String
}

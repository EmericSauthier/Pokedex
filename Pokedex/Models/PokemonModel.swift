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
    
    static func toString(pokemon: Pokemon) -> String {
        do {
            return try JSONEncoder().encode(pokemon).base64EncodedString()
        } catch {
            print("Erreur : \(error)")
            return ""
        }
    }
    
    static func toJson(stringObject: String) -> Pokemon? {
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
            string += "\(type.type.name)  "
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

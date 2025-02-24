//
//  TypeModel.swift
//  Pokedex
//
//  Created by Emeric SAUTHIER on 2/17/25.
//

import Foundation
import SwiftUI

struct PokemonType: Codable, Identifiable {
    var type: PokemonTypeInfo
    
    var id: String { type.name }
    var name: String { type.name }
    var icon: Image { type.getIcon() }
}

struct PokemonTypeInfo: Codable {
    var name: String
    
    func getIcon() -> Image {
        return Image(name.capitalized + "Type")
    }
}

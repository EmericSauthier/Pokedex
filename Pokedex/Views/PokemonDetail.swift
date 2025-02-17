//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Emeric SAUTHIER on 2/17/25.
//

import SwiftUI
import Foundation

struct PokemonDetail: View {
    
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            Text(pokemon.name)
        }
    }
}

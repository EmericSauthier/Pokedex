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
            AsyncImage(url: URL(string: pokemon.sprites.front_default!)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            Text(pokemon.name.capitalized)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .fontWidth(Font.Width.expanded)
        }
    }
}

//
//  ContentView.swift
//  Pokedex
//
//  Created by Emeric SAUTHIER on 2/17/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PokemonEntity.id, ascending: true)],
        animation: .default)
    private var pokemons: FetchedResults<PokemonEntity>
    
    @EnvironmentObject var pokemonViewModel: PokemonViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(pokemonViewModel.pokemons) { pokemon in
                    NavigationLink {
                        PokemonDetail(pokemon: pokemon)
                    } label: {
                        HStack {
                            AsyncImage(url: URL(string: pokemon.sprites.front_default!)) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 64, height: 64)
                            
                            VStack(alignment: .leading) {
                                Text(pokemon.name.capitalized)
                                Text("Types :" + pokemon.getTypes())
                            }
                        }
                    }
                }
            }
        }
        .task {
            await pokemonViewModel.initializeData()
        }
    }
}

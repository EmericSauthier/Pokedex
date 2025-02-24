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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteEntity.id, ascending: true)],
        animation: .default)
    private var favorites: FetchedResults<FavoriteEntity>
    
    @EnvironmentObject var pokemonViewModel: PokemonViewModel
    
    @State var pokemonsDisplayed: [Pokemon] = []
    @State var pokemonSearched: String = ""
    
    var body: some View {
        NavigationView {
            List {
                // pokemonViewModel.pokemons
                ForEach(pokemonsDisplayed) { pokemon in
                    NavigationLink {
                        PokemonDetail(pokemon: pokemon)
                            .environmentObject(pokemonViewModel)
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
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .toolbar(content: {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Rechercher un pokemon", text: $pokemonSearched)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .onChange(of: $pokemonSearched.wrappedValue, {
                            if $pokemonSearched.wrappedValue.isEmpty {
                                pokemonsDisplayed = pokemonViewModel.pokemons
                            } else {
                                pokemonsDisplayed = pokemonViewModel.pokemons.filter({
                                    let string = NSString(string: $0.name.lowercased())
                                    return string.contains(String($pokemonSearched.wrappedValue).lowercased())
                                })
                            }
                        })
                }
            })
        }
        .task {
            await pokemonViewModel.initializeData()
            pokemonsDisplayed = pokemonViewModel.pokemons
        }
    }
}

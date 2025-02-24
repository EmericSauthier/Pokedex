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
    
    @EnvironmentObject var pokemonViewModel: PokemonViewModel
    
    @State var pokemonsDisplayed: [Pokemon] = []
    @State var pokemonSearched: String = ""
    @State var pokemonTypeFiltered: String = "All Types"
    @State var pokemonTypesAvailable: [String] = ["All Types"]
    @State var pokemonSortAscending: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 15)
                
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Rechercher un pokemon", text: $pokemonSearched)
                            .padding(8)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .onChange(of: $pokemonSearched.wrappedValue, applyFilters)
                    }
                    
                    HStack {
                        Picker("Filtre type", selection: $pokemonTypeFiltered) {
                            ForEach(pokemonTypesAvailable, id: \.self) { type in
                                Text(String(describing: type))
                            }
                        }
                        .onChange(of: $pokemonTypeFiltered.wrappedValue, applyFilters)
                    }
                    HStack {
                        Button(action: {
                            $pokemonSortAscending.wrappedValue.toggle()
                            applyFilters()
                        }, label: {
                            if $pokemonSortAscending.wrappedValue {
                                Text("Z -> A")
                            } else {
                                Text("A -> Z")
                            }
                        })
                    }
                }
                .padding(.horizontal, 26)
                
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
            }
            .navigationTitle("Mon Pokédex")
            .task {
                await pokemonViewModel.initializeData()
                pokemonsDisplayed = pokemonViewModel.pokemons
                pokemonsDisplayed.forEach({ pokemon in
                    pokemon.types.forEach({ type in
                        if !pokemonTypesAvailable.contains(where: { $0 == type.name }) {
                            pokemonTypesAvailable.append(type.name)
                        }
                    })
                })
            }
        }
    }
    
    func applyFilters() {
        pokemonsDisplayed = pokemonViewModel.pokemons
        pokemonsDisplayed = searchPokemonByName(pokemonList: pokemonsDisplayed)
        pokemonsDisplayed = filterPokemonByType(pokemonList: pokemonsDisplayed)
        pokemonsDisplayed = sortPokemonByName(pokemonList: pokemonsDisplayed)
    }
    
    func searchPokemonByName(pokemonList: [Pokemon]) -> [Pokemon] {
        if $pokemonSearched.wrappedValue.isEmpty {
            return pokemonList
        } else {
            return pokemonList.filter({
                let string = NSString(string: $0.name.lowercased())
                return string.contains(String($pokemonSearched.wrappedValue).lowercased())
            })
        }
    }
    
    func filterPokemonByType(pokemonList: [Pokemon]) -> [Pokemon] {
        if $pokemonTypeFiltered.wrappedValue == "All Types" {
            return pokemonList
        } else {
            return pokemonList.filter({
                $0.getTypesToArray().contains(where: {
                    $0.lowercased() == $pokemonTypeFiltered.wrappedValue.lowercased()
                })
            })
        }
    }
    
    func sortPokemonByName(pokemonList: [Pokemon]) -> [Pokemon] {
        return pokemonList.sorted(by: { ($0.name.lowercased() > $1.name.lowercased()) && $pokemonSortAscending.wrappedValue })
    }
}

//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Emeric SAUTHIER on 2/17/25.
//

import Foundation

class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    
    func initializeData() async {
        pokemons = await ApiService().loadData()
    }
    
    func saveToCache() {
        PersistenceController.clearCache()
        
        let viewContext = PersistenceController.shared.container.viewContext
        
        for pokemon in pokemons {
            let entity = PokemonEntity(context: viewContext)
            entity.id = pokemon.id
            entity.name = pokemon.name
            entity.sprites = pokemon.sprites
            entity.types = pokemon.types
        }
        
        do {
            print("Data saved to cache")
        } catch {
            print("Error : \(error)")
        }
    }
}

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
            entity.id = Int64(pokemon.id)
            entity.data = Pokemon.toString(pokemon: pokemon)
        }
        
        do {
            PersistenceController.saveCache()
            print("Data saved to cache")
        } catch {
            print("Error : \(error)")
        }
    }
}

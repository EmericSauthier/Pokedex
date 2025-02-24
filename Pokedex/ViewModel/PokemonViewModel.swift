//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Emeric SAUTHIER on 2/17/25.
//

import Foundation
import CoreData

class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var favorites: [Pokemon] = []
    
    func initializeData() async {
        print("En mémoire : \(PersistenceController.shared.container.viewContext.retainsRegisteredObjects)")
        if PersistenceController.shared.container.viewContext.retainsRegisteredObjects {
            pokemons = loadPokemonFromCache()
            favorites = loadFavoritesFromCache()
        } else {
            pokemons = await ApiService().loadData()
            saveToCache()
        }
    }
    
    func saveToCache() {
        PersistenceController.clearPokemons()
        
        let viewContext = PersistenceController.shared.container.viewContext
        
        for pokemon in pokemons {
            let entity = PokemonEntity(context: viewContext)
            entity.id = Int64(pokemon.id)
            entity.data = Pokemon.toString(pokemon: pokemon)
        }
        
        PersistenceController.saveCache()
    }
    
//    func loadFromCache() -> [Pokemon] {
//        let viewContext = PersistenceController.shared.container.viewContext
//        let fetchRequest: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
//        var pokemonList: [Pokemon] = []
//        
//        do {
//            let results = try viewContext.fetch(fetchRequest)
//            
//            for result in results {
//                let pokemon = Pokemon.toJson(stringObject: result.data ?? "")
//                if pokemon != nil {
//                    pokemonList.append(pokemon!)
//                }
//            }
//        } catch {
//            print("Erreur : \(error)")
//        }
//        
//        return pokemonList
//    }
    
    func loadPokemonFromCache() -> [Pokemon] {
        return PersistenceController.loadPokemons()
    }
    
    func loadFavoritesFromCache() -> [Pokemon] {
        return PersistenceController.loadFavorites()
    }
    
    func addToFavorites(pokemon: Pokemon) {
        let viewContext = PersistenceController.shared.container.viewContext
        
        let entity = FavoriteEntity(context: viewContext)
        entity.id = Int64(pokemon.id)
        entity.data = Pokemon.toString(pokemon: pokemon)
        
        PersistenceController.saveCache()
    }
    
    func clearFavorites() {
        
    }
}

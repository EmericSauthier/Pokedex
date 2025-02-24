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
        pokemons = loadPokemonFromCache()
        favorites = loadFavoritesFromCache()
        
        if pokemons.count == 0 {
            pokemons = await ApiService().loadData()
            savePokemons()
            
            favorites = []
        }
    }
    
    func loadPokemonFromCache() -> [Pokemon] {
        return PersistenceController.loadPokemons()
    }
    
    func loadFavoritesFromCache() -> [Pokemon] {
        return PersistenceController.loadFavorites()
    }
    
    func clearPokemons() {
        PersistenceController.clearPokemons()
        
        pokemons = loadPokemonFromCache()
    }
    
    func clearFavorites() {
        PersistenceController.clearFavorites()
        
        favorites = loadFavoritesFromCache()
    }
    
    func clearFavorite(pokemon: Pokemon) {
        PersistenceController.clearFavorite(pokemon: pokemon)
        
        favorites = loadFavoritesFromCache()
    }
    
    func addToFavorites(pokemon: Pokemon) {
        if favorites.contains(where: { $0.id == pokemon.id }) {
            return
        }
        
        let viewContext = PersistenceController.shared.container.viewContext
        
        let entity = FavoriteEntity(context: viewContext)
        entity.id = Int64(pokemon.id)
        
        entity.data = Pokemon.toString(pokemon: pokemon)
        
        PersistenceController.saveCache()
        favorites = PersistenceController.loadFavorites()
    }
    
    func savePokemons() {
        PersistenceController.clearPokemons()
        
        let viewContext = PersistenceController.shared.container.viewContext
        
        for pokemon in pokemons {
            let entity = PokemonEntity(context: viewContext)
            entity.id = Int64(pokemon.id)
            entity.data = Pokemon.toString(pokemon: pokemon)
        }
        
        PersistenceController.saveCache()
        
        pokemons = loadPokemonFromCache()
    }
}

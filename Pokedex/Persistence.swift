//
//  Persistence.swift
//  Pokedex
//
//  Created by Emeric SAUTHIER on 2/17/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Pokedex")
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // Sauvegarde les données en cache
    static func saveCache() {
        let context = PersistenceController.shared.container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Erreur saveCache : \(error)")
            }
        }
    }
    
    static func loadPokemons() -> [Pokemon] {
        let fetchRequest: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        var pokemonList: [Pokemon] = []
        
        do {
            let results = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            
            for result in results {
                let pokemon = Pokemon.toJson(stringObject: result.data ?? "")
                if pokemon != nil {
                    pokemonList.append(pokemon!)
                }
            }
        } catch {
            print("Erreur loadPokemons : \(error)")
        }
        
        return pokemonList
    }
    
    static func clearPokemons() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PokemonEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try PersistenceController.shared.container.viewContext.execute(deleteRequest)
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            print("Erreur clearPokemons : \(error)")
        }
    }
    
    // -------------------
    // GESTION DES FAVORIS
    // -------------------
    
    // Chargement des favoris
    static func loadFavorites() -> [Pokemon] {
        let fetchRequest: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
        var pokemonList: [Pokemon] = []
        
        do {
            let results = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            
            for result in results {
                let pokemon = Pokemon.toJson(stringObject: result.data ?? "")
                if pokemon != nil {
                    pokemonList.append(pokemon!)
                }
            }
        } catch {
            print("Erreur loadFavorites : \(error)")
        }
        
        return pokemonList
    }
    
    // Efface tous les favoris
    static func clearFavorites() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FavoriteEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try PersistenceController.shared.container.viewContext.execute(deleteRequest)
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            print("Erreur clearFavorites : \(error)")
        }
    }
    
    // Efface un favori
    static func clearFavorite(pokemon: Pokemon) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FavoriteEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == " + String(Int64(pokemon.id)))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try PersistenceController.shared.container.viewContext.execute(deleteRequest)
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            print("Erreur clearFavorite : \(error)")
        }
    }
}

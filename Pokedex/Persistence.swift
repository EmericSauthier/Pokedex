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
    
    static func clearCache() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PokemonEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try PersistenceController.shared.container.viewContext.execute(deleteRequest)
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            print("Erreur : \(error)")
        }
    }
    
    static func saveCache() {
        let context = PersistenceController.shared.container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Erreur : \(error)")
            }
        }
    }
}

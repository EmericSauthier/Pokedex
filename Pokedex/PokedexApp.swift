//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Emeric SAUTHIER on 2/17/25.
//

import SwiftUI

@main
struct PokedexApp: App {
    let persistenceController = PersistenceController.shared
    
    @ObservedObject var pokemonViewModel: PokemonViewModel = PokemonViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(pokemonViewModel)
        }
    }
}

//
//  ApiService.swift
//  Pokedex
//
//  Created by Emeric SAUTHIER on 2/17/25.
//

import Foundation

class ApiService {
    // Charge une liste de 20 pokemons
    func loadData() async -> [Pokemon] {
        do {
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=20")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"  // optional
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedData = try JSONDecoder().decode(PokemonInfoResponse.self, from: data)
            
            var pokemonData: [Pokemon] = []
            
            for info in decodedData.results {
                if let pokemon: Pokemon = await loadPokemonData(pokemonInfo: info) {
                    pokemonData.append(pokemon)
                }
            }
            
            return pokemonData
        } catch {
            print("Failed to decode json", error)
            
            return []
        }
    }
    
    // Charge les données des pokemons chargés précédemment
    func loadPokemonData(pokemonInfo: PokemonInfo) async -> Pokemon? {
        do {
            let url = URL(string: pokemonInfo.url)!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"  // optional
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedData = try JSONDecoder().decode(Pokemon.self, from: data)
            
            return decodedData
        } catch {
            print("Failed to decode json", error)
            
            return nil
        }
    }
}

//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Emeric SAUTHIER on 2/17/25.
//

import SwiftUI
import Foundation

struct PokemonDetail: View {
    
    @EnvironmentObject var pokemonViewModel: PokemonViewModel
    
    @State var imgAnim = false
    @State var nameAnim = false
    
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.sprites.front_default!)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .scaleEffect(imgAnim ? 1.0 : 0.0)
            .onAppear {
                withAnimation(.easeOut(duration: 1.0)) { imgAnim = true }
            }
            
            Text(pokemon.name.capitalized)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .fontWidth(Font.Width.expanded)
            
            HStack { 
                ForEach(pokemon.types) { typeInfo in
                    typeInfo.type.getIcon()
                        .resizable()
                        .frame(width: 32, height: 32)
                }
            }
            
            Text("HP : \(pokemon.hp)")
            Text("Attack : \(pokemon.attack)")
            Text("Defense : \(pokemon.defense)")
            Text("Speed : \(pokemon.speed)")
            
            Button(action: {
                if pokemonViewModel.favorites.contains(where: { $0.id == pokemon.id }) {
                    print("Clear favorite \(pokemonViewModel.favorites.contains(where: { $0.id == pokemon.id }))")
                    pokemonViewModel.clearFavorite(pokemon: pokemon)
                } else {
                    print("Add To Favorite")
                    pokemonViewModel.addToFavorites(pokemon: pokemon)
                }
            }, label: {
                if pokemonViewModel.favorites.contains(where: { $0.id == pokemon.id }) {
                    Text("Retirer des favoris")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding(8)
                        .background(.red)
                        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                } else {
                    Text("Ajouter aux favoris")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding(8)
                        .background(.blue)
                        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                }
                
            })
        }
    }
}

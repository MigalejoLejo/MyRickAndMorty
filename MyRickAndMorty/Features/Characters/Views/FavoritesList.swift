//
//  FavoriteList.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 31.05.2025.
//


import SwiftUI

struct FavoritesList: View {
    @EnvironmentObject var Characters: CharacterListViewModel

    
    var body: some View {
        
        CharacterList(title: "Favorites", favoritesOnly: true)
            .environmentObject(Characters)

        
    }
}


#Preview{
    FavoritesList()
        .environmentObject(CharacterListViewModel())
}

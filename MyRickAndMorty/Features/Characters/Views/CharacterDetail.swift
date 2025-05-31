//
//  CharacterDetailView.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 20.05.2025.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    let favButtonAction: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, minHeight: 200)
                }

                HStack{
                    Text(character.name)
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    FavButton(isActive: character.isFavorite, action: favButtonAction) 
                }
                characterInfo(title: "Status", value: character.status)
                characterInfo(title: "Species", value: character.species)
                if !character.type.isEmpty {
                    characterInfo(title: "Type", value: character.type)
                }
                characterInfo(title: "Gender", value: character.gender)
                characterInfo(title: "Origin", value: character.origin.name)
                characterInfo(title: "Last Location", value: character.location.name)

                
               

                Spacer()
            }
            .padding()
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func characterInfo(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.title3)
                .foregroundColor(.secondary)
            Text(value)
                .font(.title)
        }
    }
}




#Preview {
    CharacterDetailView(character: .mock) {
        print("fav button pressed on details view")
    }
}

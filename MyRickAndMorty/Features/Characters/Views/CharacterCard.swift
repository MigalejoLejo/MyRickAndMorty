//
//  CharacterCard.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 20.05.2025.
//

import SwiftUI
import Kingfisher

struct CharacterCard: View {
    let character: Character
    let favButtonAction: () -> Void
    
    var body: some View {
        NavigationLink {
            CharacterDetailView(character: character, favButtonAction: favButtonAction)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                CardImage(imageURL: character.image)
                
                HStack(alignment: .center, spacing: 4){
                    NameAndSpecies(from: character)
                    Spacer()
                    GenderAndStatus(from: character)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                .padding(.top, 5)
                
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            .overlay (alignment: .topTrailing) {
                FavButton(isActive: character.isFavorite, action: favButtonAction)
                .padding(15)
            }
        }
    }
}


struct CardImage: View {
    let imageURL: String

    var body: some View {
        KFImage(URL(string: imageURL))
            .placeholder {
                ProgressView()
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
            }
            .cancelOnDisappear(true)
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .clipShape(RoundedTopCorners(radius: 12))
            .clipped()
    }
}

struct NameAndSpecies: View {
    let character: Character
    
    init(from input: Character) {
        self.character = input
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(character.name)
                .font(.title2)
                .lineLimit(1)
            
            Text(character.species)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct GenderAndStatus: View {
    let character: Character
    
    init(from input: Character) {
        self.character = input
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Image (systemName: character.genderIcon)
                .foregroundColor(character.genderIconColor)
                .padding(.trailing, 2)
            
            Text(character.status)
                .font(.subheadline)
                .foregroundColor(character.statusColor)
        }
    }
}


#Preview {
    CharacterCard(character: .mock) {
        print("card fav pressed")
    }
}

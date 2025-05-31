//
//  CharacterModel.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 20.05.2025.
//

import Foundation


struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationReference
    let location: LocationReference
    let image: String
    let episode: [String]
    let url: String
    let created: String
    var isFavorite: Bool
}

struct APICharacter: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationReference
    let location: LocationReference
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    func toCharacter(isFavorite: Bool) -> Character {
        Character(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            location: location,
            image: image,
            episode: episode,
            url: url,
            created: created,
            isFavorite: isFavorite
        )
    }
}

struct LocationReference: Codable {
    let name: String
    let url: String
}

struct CharacterResponse: Codable {
    let info: PageInfo
    let results: [APICharacter]
}

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

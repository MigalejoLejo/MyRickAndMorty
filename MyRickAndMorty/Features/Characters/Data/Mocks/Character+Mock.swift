//
//  CharacterMock.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 20.05.2025.
//

extension Character {
    static var mock: Character {
        Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: LocationReference(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
            location: LocationReference(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2"
            ],
            url: "https://rickandmortyapi.com/api/character/1",
            created: "2017-11-04T18:48:46.250Z",
            isFavorite: true
        )
    }
}

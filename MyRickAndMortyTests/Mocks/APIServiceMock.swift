//
//  APIServiceMock.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 21.05.2025.
//

import Foundation

class APIServiceMock: CharacterService {
    let shouldFail: Bool

    init(shouldFail: Bool) {
        self.shouldFail = shouldFail
    }

    func fetchCharacters(from url: URL?, filters: [String: String]?) async throws -> CharacterResponse {
        if shouldFail {
            throw URLError(.badServerResponse)
        } else {
            let mockCharacter = Character(
                id: 1,
                name: "Test",
                status: "Alive",
                species: "Human",
                type: "",
                gender: "Male",
                origin: LocationReference(name: "Earth", url: ""),
                location: LocationReference(name: "Citadel of Ricks", url: ""),
                image: "",
                episode: [],
                url: "",
                created: ""
            )
            return CharacterResponse(
                info: PageInfo(count: 1, pages: 1, next: nil, prev: nil),
                results: [mockCharacter]
            )
        }
    }
}

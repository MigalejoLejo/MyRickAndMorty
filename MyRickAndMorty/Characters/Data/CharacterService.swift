//
//  CharacterService.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 20.05.2025.
//

import Foundation

protocol CharacterService {
    func fetchCharacters(from url: URL?) async throws -> CharacterResponse
}

extension CharacterService {
    func fetchCharacters() async throws -> CharacterResponse {
        try await fetchCharacters(from: nil)
    }
}

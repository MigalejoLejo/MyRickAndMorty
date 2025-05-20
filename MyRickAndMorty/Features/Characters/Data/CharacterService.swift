//
//  CharacterService.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 20.05.2025.
//

import Foundation

protocol CharacterService {
    func fetchCharacters(from url: URL?, filters: [String: String]?) async throws -> CharacterResponse
}

extension CharacterService {
    // No params
    func fetchCharacters() async throws -> CharacterResponse {
        try await fetchCharacters(from: nil, filters: nil)
    }

    // Only URL (pagination)
    func fetchCharacters(from url: URL?) async throws -> CharacterResponse {
        try await fetchCharacters(from: url, filters: nil)
    }

    // Only filters (search, filter)
    func fetchCharacters(filters: [String: String]?) async throws -> CharacterResponse {
        try await fetchCharacters(from: nil, filters: filters)
    }
}

//
//  APIServiceFailing.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 21.05.2025.
//

import Foundation

final class APIServiceFailing: CharacterService {
    static let shared = APIServiceFailing()
    private init() {}

    func fetchCharacters(from url: URL?, filters: [String: String]?) async throws -> CharacterResponse {
        throw APIError.invalidURL
    }
}

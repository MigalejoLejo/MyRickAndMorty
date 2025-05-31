//
//  APIServiceDelayed.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 20.05.2025.
//

import Foundation

final class APIServiceDelayed: CharacterService {
    static let shared = APIServiceDelayed()
    private init() {}

    private let baseURL = "https://rickandmortyapi.com/api/character"

    func fetchCharacters(from url: URL? = nil, filters: [String:String]?) async throws -> CharacterResponse {
        let urlToUse = url ?? URL(string: baseURL)

        let finalURL = try getFinalURL(base: urlToUse, filters: filters)
        
        // Simulate network delay
        try await Task.sleep(nanoseconds: 5_000_000_000)

        let (data, _) = try await URLSession.shared.data(from: finalURL)
        let decodedResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
        
        print(decodedResponse)
        return decodedResponse
    }
}

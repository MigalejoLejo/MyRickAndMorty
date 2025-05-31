//
//  APIServiceCombine.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 20.05.2025.
//

import Foundation
import Combine

final class APIServiceCombine: CharacterService {
    static let shared = APIServiceCombine()
    private init() {}

    private let baseURL = "https://rickandmortyapi.com/api/character"

    func fetchCharacters(from url: URL?, filters: [String: String]?) async throws -> CharacterResponse {
        let base = url ?? URL(string: baseURL)
        
        let finalURL = try getFinalURL(base: base, filters: filters)

        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTaskPublisher(for: finalURL)
                .map(\.data)
                .decode(type: CharacterResponse.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        continuation.resume(throwing: error)
                    }
                }, receiveValue: { response in
                    continuation.resume(returning: response)
                })
                .store(in: &self.cancellables)
        }
    }

    private var cancellables = Set<AnyCancellable>()
}

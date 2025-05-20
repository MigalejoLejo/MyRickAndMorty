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

    func fetchCharacters(from url: URL? = nil) async throws -> CharacterResponse {
        let urlToUse = url ?? URL(string: baseURL)

        guard let finalURL = urlToUse else {
            throw APIError.invalidURL
        }

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

import Foundation

final class APIService: CharacterService {
    static let shared = APIService()
    private init() {}

    private let baseURL = "https://rickandmortyapi.com/api/character"

    func fetchCharacters(from url: URL?, filters: [String: String]?) async throws -> CharacterResponse {
        let base = url ?? URL(string: baseURL)

        let finalURL = try getFinalURL(base: base, filters: filters)

        let (data, _) = try await URLSession.shared.data(from: finalURL)
        let decodedResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)

        return decodedResponse
    }
}

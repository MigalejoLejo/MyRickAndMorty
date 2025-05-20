//
//  CharacterViewModel.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 20.05.2025.
//

import Foundation

@MainActor
class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var hasMorePages: Bool {
        nextPageURL != nil
    }
    
    private var service: CharacterService
    private var nextPageURL: URL?
    
    init(service: CharacterService = APIService.shared) {
        self.service = service
    }
    
    
    func loadInitialCharacters() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await service.fetchCharacters()
            characters = response.results
            nextPageURL = URL(string: response.info.next ?? "")
            errorMessage = nil
        } catch {
            errorMessage = "Error loading characters: \(error.localizedDescription)"
            print("Error loading characters:", error)
        }
    }
    
    func loadMoreCharacters() async {
        guard !isLoading, let nextURL = nextPageURL else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await service.fetchCharacters(from: nextURL)
            characters += response.results
            nextPageURL = URL(string: response.info.next ?? "")
            errorMessage =  nil
        } catch {
            errorMessage = "Error loading characters: \(error.localizedDescription)"
            print("Error loading more characters:", error)
        }
    }
    
    func triggerLoadMoreCharacters(basedOn character: Character) {
        guard !isLoading,
              nextPageURL != nil,
              character.id == characters.last?.id else { return }

        Task {
            await loadMoreCharacters()
        }
    }
}


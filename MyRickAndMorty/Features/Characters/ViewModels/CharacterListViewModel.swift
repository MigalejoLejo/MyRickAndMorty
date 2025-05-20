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
    
    @Published var filter = CharacterFilter()
    @Published var isShowingFilterSheet = false
    
    private var activeFilters: [String: String]? {
        filter.asQueryParameters
    }
    
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
            let response = try await service.fetchCharacters(filters: activeFilters)
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
            let response = try await service.fetchCharacters(from: nextURL, filters: activeFilters)
            characters += response.results
            nextPageURL = URL(string: response.info.next ?? "")
            errorMessage = nil
        } catch {
            errorMessage = "Error loading characters: \(error.localizedDescription)"
            print("Error loading more characters:", error)
        }
    }
    
    func applyFilters () async {
        characters = []
        await loadInitialCharacters()
    }
    
    func triggerLoadMoreCharacters(basedOn character: Character) {
        guard !isLoading,
              nextPageURL != nil,
              character.id == characters.last?.id else { return }
        
        Task {
            await loadMoreCharacters()
        }
    }
    
    func retry () {
        self.service = APIService.shared
        self.errorMessage = nil
        self.characters = []
        self.nextPageURL = nil
    }
}


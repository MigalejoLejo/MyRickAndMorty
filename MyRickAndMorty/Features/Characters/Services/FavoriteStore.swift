//
//  FavoriteService.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 31.05.2025.
//

import Foundation

class FavoriteStore: ObservableObject {
    static let shared = FavoriteStore()

    private let key = "favoriteIDs"
    @Published var favorites: Set<Int> = []

    init() {
        load()
    }

    func isFavorite(_ id: Int) -> Bool {
        favorites.contains(id)
    }

    func toggle(_ id: Int) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
        save()
    }

    private func save() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode(Set<Int>.self, from: data) {
            favorites = decoded
        }
    }

    func all() -> Set<Int> {
        return favorites
    }
}

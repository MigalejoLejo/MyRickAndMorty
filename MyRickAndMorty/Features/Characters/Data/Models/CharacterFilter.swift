//
//  CharacterFilter.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 20.05.2025.
//

struct CharacterFilter: Equatable {
    var name: String = ""
    var status: String = "all"
    var gender: String = "all"
    
    var asQueryParameters: [String: String]? {
        var filters: [String: String] = [:]
        if !name.isEmpty {
            filters["name"] = name
        }
        if status != "all" {
            filters["status"] = status
        }
        if gender != "all" {
            filters["gender"] = gender
        }
        return filters.isEmpty ? nil : filters
    }
    
    var isEmpty: Bool {
        asQueryParameters == nil
    }
}

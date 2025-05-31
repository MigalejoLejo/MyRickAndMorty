//
//  APIService+helpers.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 20.05.2025.
//

import Foundation
func getFinalURL (base:URL? , filters: [String:String]? ) throws -> URL {
    
    guard var components = URLComponents(url: base!, resolvingAgainstBaseURL: false) else {
        throw APIError.invalidURL
    }
    
    if let filters = filters {
        components.queryItems = filters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
    guard let finalURL = components.url else {
        throw APIError.invalidURL
    }
    
    return finalURL
}


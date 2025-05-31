//
//  NavigationOptions.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 31.05.2025.
//

import SwiftUI
enum NavigationOptions: String, CaseIterable {
    case Episodes, Characters, Locations

    var title: String {
        switch self {
        case .Episodes: return "Episodes"
        case .Characters: return "Characters"
        case .Locations: return "Locations"
        }
    }

    var imageName: String {
        switch self {
        case .Episodes: return "Episodes"
        case .Characters: return "Characters"
        case .Locations: return "Locations"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .Episodes: return .blue
        case .Characters: return .green
        case .Locations: return .purple
        }
    }
}

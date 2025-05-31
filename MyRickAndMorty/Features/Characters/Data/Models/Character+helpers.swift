//
//  Character+helpers.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 20.05.2025.
//

import SwiftUI

extension Character {
    var statusColor: Color {
        switch status.lowercased() {
        case "alive": return .green
        case "dead": return .red
        default: return .gray
        }
    }
    
    var genderIcon: String {
        switch gender.lowercased() {
        case "male": return "person.fill"
        case "female": return "person.fill"
        case "genderless": return "circle"
        default: return "questionmark.circle"
        }
    }
    
    var genderIconColor: Color {
        switch gender.lowercased() {
        case "male": return .blue
        case "female": return .pink
        case "genderless": return .gray
        default: return .gray
        }
    }
}


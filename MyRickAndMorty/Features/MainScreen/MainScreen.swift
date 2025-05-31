//
//  MainScreen.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 31.05.2025.
//

import SwiftUI

struct MainScreen: View {
    @State private var selectedTab = 1
    @StateObject private var Characters: CharacterListViewModel
    
    init() {
        let service: CharacterService
        if CommandLine.arguments.contains("--UITest_ShowError") {
            service = APIServiceMock(shouldFail: true)
        } else if CommandLine.arguments.contains("--UITest_SuccessState") {
            service = APIServiceMock(shouldFail: false)
        } else {
            service = APIService.shared
        }
        
        _Characters = StateObject(wrappedValue: CharacterListViewModel(service: service))
    }
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            CharacterList()
                .environmentObject(Characters)
                .tabItem {
                    VStack {
                        Image(systemName: "person.2")
                        Text("Characters")
                    }
                }
                .tag(1)
            
            CharacterList(title: "Favorites", favoritesOnly: true)
                .environmentObject(Characters)

                .tabItem {
                    VStack {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }
                }
                .tag(2)
        }
    }
}

#Preview {
    MainScreen()
}

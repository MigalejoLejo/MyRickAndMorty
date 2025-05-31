//
//  MainScreen.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 31.05.2025.
//

import SwiftUI

struct MainScreen: View {
    @StateObject private var Characters: CharacterListViewModel
    @State var showSettings = false
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
        NavigationView{
            ScrollView{
                VStack{
                    ForEach(NavigationOptions.allCases, id: \.self){ option in
                        NavigationCard(for: option)
                    }
                    
                    Spacer()
                    FooterDisclaimer()
                }
            }
            .navigationTitle("Choose your portal")
            .toolbar {
                ToolbarItem {
                    Button {
                        showSettings.toggle()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .buttonStyle(.plain)
                }
            }        .settingsSheet(isPresented: $showSettings)
        }
        .environmentObject(Characters)
    }
}

#Preview {
    MainScreen()
}

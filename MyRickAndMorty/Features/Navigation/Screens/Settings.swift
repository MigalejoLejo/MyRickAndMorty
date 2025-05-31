//
//  Settings.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 01.06.2025.
//

import SwiftUI
import SwiftUI

struct Settings: ViewModifier {
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content.sheet(isPresented: $isPresented) {
            NavigationView {
                VStack(alignment: .leading) {
                    Text("Hello Settings")
                        .padding(.horizontal)
                }
                .navigationTitle("Settings")
                .toolbar {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

extension View {
    func settingsSheet(isPresented: Binding<Bool>) -> some View {
        self.modifier(Settings(isPresented: isPresented))
    }
}


#Preview {
    MainScreen()
}

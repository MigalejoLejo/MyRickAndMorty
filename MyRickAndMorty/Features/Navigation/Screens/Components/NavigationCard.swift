//
//  NavigationCard.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 31.05.2025.
//

import SwiftUI

struct NavigationCard: View {
    
    let option: NavigationOptions
    
    init(for option: NavigationOptions){
        self.option = option
    }

    
    var body: some View {
        NavigationLink  {
            destinationView(for: option)
        } label: {
            GeometryReader { proxy in
                VStack(alignment: .center, spacing: 8) {
                    Image(option.imageName)
                        .resizable()
                        .frame(width: proxy.size.width , height: 200)
                    Text(option.title)
                    
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        .padding(.top, 5)
                    
                }
                .background(Color(option.backgroundColor).opacity(0.7))
                .cornerRadius(12)
            }
            .frame(height: 260)
            .padding(.horizontal)

            


        }
        .buttonStyle(PlainButtonStyle())


      
    }
}

@ViewBuilder
    func destinationView(for option: NavigationOptions) -> some View {
        switch option {
        case .Episodes:
            Text("Episodes View")
        case .Characters:
            CharacterList()
        case .Locations:
            Text("Locations View")
        }
    }

#Preview {
    MainScreen()
}

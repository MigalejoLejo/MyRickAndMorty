//
//  FavButton.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 28.05.2025.
//

import SwiftUI

struct FavButton: View {
 
    var isActive: Bool
    var action: () -> Void
    
    
    var body: some View {
        
            Circle()
            .frame(width: 40, height: 40)
            .foregroundColor(.white.opacity(0.2))
        
            .overlay {
                Button {
                    action()
                } label: {
                    Image(systemName: isActive ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 20, height: 18)
                        .foregroundColor(.red)
                        .padding(.top, 2)
                        .padding(.horizontal, 1)
                }.padding(20)
            }
        
    }
}

#Preview {
    FavButton(isActive: true) {
        print("hello")
    }
}

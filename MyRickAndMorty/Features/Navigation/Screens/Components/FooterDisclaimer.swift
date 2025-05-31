//
//  FooterDisclaimer.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 01.06.2025.
//

import SwiftUI

struct FooterDisclaimer: View {
    
    var body: some View {
        Text("""
        This app is unofficial and not affiliated with or endorsed by the creators of Rick and Morty or Warner Bros.
        It was created for learning purposes and pursues no commercial intent.
        
        This app uses the Rick and Morty API (https://rickandmortyapi.com), which is licensed under the BSD 2-Clause License.

        The effort put into this app is dedicated to my family. I love you guys!
        """)
        .font(.system(size: 11))
        .foregroundColor(.gray)
        .multilineTextAlignment(.center)
        .padding()
    }
}

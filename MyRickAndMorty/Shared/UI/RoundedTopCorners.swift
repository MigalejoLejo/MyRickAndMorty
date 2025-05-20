//
//  RoundedTopCorners.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 20.05.2025.
//

import SwiftUI

struct RoundedTopCorners: Shape {
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

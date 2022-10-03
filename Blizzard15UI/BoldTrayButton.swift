//
//  BoldTrayButton.swift
//  Blizzard15UI
//
//  Created by Redentic on 10/02/2022.
//

import SwiftUI

struct BoldTrayButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Color.clear
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
            configuration.label
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(Color(uiColor: .label))
        }
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
        .animation(.easeIn(duration: 0.2), value: configuration.isPressed)
        .shadow(color: .black.opacity(0.1), radius: 16)
    }
}

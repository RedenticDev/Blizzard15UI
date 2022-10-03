//
//  View+Condition.swift
//  Blizzard15UI
//
//  Created by Antoine Lethimonnier on 03/10/2022.
//

import SwiftUI

extension View {
    
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}

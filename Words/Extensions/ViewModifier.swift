//
//  ViewModifier.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

struct VisibilityStyle: ViewModifier {
    
    let isVisible: Bool
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if isVisible {
            content
        } else {
            EmptyView()
        }
    }
}

struct ButtonWrapper: ViewModifier {
    
    var action: () -> Void
    
    @ViewBuilder
    func body(content: Content) -> some View {
        Button {
            action()
        } label: {
            content
        }
    }
}

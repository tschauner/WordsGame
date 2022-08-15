//
//  ViewModifier.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

extension View {
    
    func isVisible(_ isVisible: Bool) -> some View {
        modifier(VisibilityStyle(isVisible: isVisible))
    }
    
    func button(action: @escaping () -> Void) -> some View {
        modifier(ButtonWrapper(action: action))
    }
    
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S: ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
             .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}

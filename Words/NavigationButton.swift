//
//  NavigationButton.swift
//  Words
//
//  Created by Philipp Tschauner on 19.08.22.
//

import SwiftUI


struct NavigationButton: View {
    
    var image: GameImage
    var action: () -> Void
    
    var body: some View {
        Image(name: image)
            .font(.blackRounded())
            .foregroundColor(.black)
            .button(action: action)
    }
}

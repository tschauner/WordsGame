//
//  GameNavigationView.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

struct GameNavigationView<LeftButton: View, RightButton: View>: View {
    
    let leftButton: () -> LeftButton
    let rightButton: () -> RightButton
    
    var body: some View {
        HStack {
            leftButton()
            Spacer()
            rightButton()
        }
        .frame(height: 40)
    }
}

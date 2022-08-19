//
//  Canvas.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

struct GameCanvas: View {
    
    var currentOriginal: String?
    var currentTranslation: String?
    var currentTextPosition: CGFloat
    
    var body: some View {
        if let original = currentOriginal,
            let translation = currentTranslation {
            
            VStack(alignment: .center, spacing: 18) {
                Text(original)
                    .font(.blackRounded(size: 36))
                    .multilineTextAlignment(.center)
                    .offset(y: currentTextPosition)
//                    .opacity(viewModel.shouldHideAnimation ? 0 : 1)
                Text(translation)
                    .font(.blackRounded(size: 30))
                    .foregroundColor(.pink)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                    .zIndex(1)
            }
            .frame(maxHeight: .infinity)
            
        } else {
            Spacer()
        }
    }
}

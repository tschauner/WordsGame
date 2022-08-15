//
//  Canvas.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

struct GameCanvas: View {
    
    @EnvironmentObject var viewModel: WordsViewModel
    
    var body: some View {
        if let original = viewModel.currentOriginal,
            let translation = viewModel.currentRandomTranslation {
            
            VStack(alignment: .center, spacing: 18) {
                Text(original)
                    .font(.blackRounded(size: 36))
                    .multilineTextAlignment(.center)
                    .offset(y: viewModel.currentTextPosition)
                    .opacity(viewModel.shouldHideAnimation ? 0 : 1)
                Text(translation)
                    .font(.blackRounded(size: 30))
                    .foregroundColor(.pink)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                    .zIndex(1)
            }
            .onChange(of: viewModel.animateText) { shouldAnimate in
                viewModel.animateText(shouldAnimate)
            }
            .frame(maxHeight: .infinity)
            
        } else {
            Spacer()
        }
    }
}

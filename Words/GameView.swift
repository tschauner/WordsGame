//
//  GameView.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

struct GameView<T: GameProtocol>: View {
    
    @StateObject var viewModel: T
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(GameSection.allCases, id: \.self) { section in
                viewForSection(section)
                    .frame(maxWidth: .infinity)
                    .isVisible(section.isVisible(viewModel: viewModel))
            }
        }
        .overlay(
            AlertView(content: {
                ChooseLanguageView(languages: Language.allCases) { language in
                    viewModel.setup(withConfig: language)
                }
            }, title: "Please choose 🤓")
            .isVisible(!viewModel.isGameReady)
        )
        .alert(viewModel.alertMessage, isPresented: $viewModel.showGameAlert) {
            viewModel.gameAlert
        }
        .onReceive(viewModel.timer) { _ in
            viewModel.setTimer()
        }
        .onChange(of: viewModel.animateText) { shouldAnimate in
            viewModel.animateText(shouldAnimate)
        }
        .padding(25)
        .background(Color.lightOrange.ignoresSafeArea())
    }
    
    @ViewBuilder
    func viewForSection(_ section: GameSection) -> some View {
        switch section {
        case .navigation:
            GameNavigationView {
                Image(name: .close)
                    .font(.blackRounded())
                    .foregroundColor(.black)
                    .button(action: viewModel.quit)
            } rightButton: {
                Image(name: .retry)
                    .font(.blackRounded())
                    .foregroundColor(.black)
                    .button(action: viewModel.reset)
            }

        case .stats:
            GameStatsView(wrongAttempts: viewModel.wrongAttempts,
                          correctAttempts: viewModel.correctAttempts,
                          timeRemaining: viewModel.timeRemaining)
                .zIndex(1)
                .padding(.top, 15)
        case .canvas:
            GameCanvas(currentOriginal: viewModel.currentOriginal,
                       currentTranslation: viewModel.currentRandomTranslation,
                       currentTextPosition: viewModel.currentTextPosition)
        case .controls:
            GameControlsView { choice in
                viewModel.choiceSelected(choice)
            }
        }
    }
}

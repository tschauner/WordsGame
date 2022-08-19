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
                    .environmentObject(viewModel)
                    .isVisible(section.isVisible(viewModel: viewModel))
            }
        }
        .overlay(
            AlertView(content: {
                ChooseLanguageView() { language in
                    viewModel.setup(withConfig: language)
                }
            }, title: "Please choose 🤓")
            .isVisible(!viewModel.isGameReady)
        )
        .alert(viewModel.alertMessage, isPresented: $viewModel.showGameAlert) {
            viewModel.gameAlert
        }
        .padding(25)
        .background(Color.lightOrange.ignoresSafeArea())
    }
    
    @ViewBuilder
    func viewForSection(_ section: GameSection) -> some View {
        switch section {
        case .navigation:
            GameNavigationView<T>()
        case .stats:
            GameStatsView<T>()
                .zIndex(1)
                .padding(.top, 15)
        case .canvas:
            GameCanvas<T>()
        case .controls:
            GameControlsView<T>()
        }
    }
}

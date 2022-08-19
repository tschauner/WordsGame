//
//  GameStatsView.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

struct GameStatsView<T: GameProtocol>: View {
    
    @EnvironmentObject var viewModel: T
    
    var body: some View {
        HStack {
            Text("💩 \(viewModel.wrongAttempts)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            TimerView<T>()
            Spacer()
            Text("\(viewModel.correctAttempts) 🏆")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .environmentObject(viewModel)
        .font(.blackRounded())
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(Color.white)
        .clipShape(Capsule())
    }
}

//
//  GameStatsView.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

struct GameStatsView: View {
    @EnvironmentObject var viewModel: WordsViewModel
    
    var body: some View {
        HStack {
            Text("💩 \(viewModel.wrongAttempts)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            TimerView()
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

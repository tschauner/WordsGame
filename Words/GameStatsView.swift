//
//  GameStatsView.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

struct GameStatsView: View {

    var wrongAttempts: Int
    var correctAttempts: Int
    var timeRemaining: Int
    
    var body: some View {
        HStack {
            Text("💩 \(wrongAttempts)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text("⏱ \(timeRemaining)")
                .font(.blackRounded(size: 26))
                .multilineTextAlignment(.center)

            Spacer()
            Text("\(correctAttempts) 🏆")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.blackRounded())
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(Color.white)
        .clipShape(Capsule())
    }
}

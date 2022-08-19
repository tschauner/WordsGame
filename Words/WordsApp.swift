//
//  WordsApp.swift
//  Words
//
//  Created by Philipp Tschauner on 11.08.22.
//

import SwiftUI

@main
struct WordsApp: App {
    var body: some Scene {
        WindowGroup {
            GameView(viewModel: GameViewModel())
        }
    }
}

//
//  LanguageViewModel.swift
//  Words
//
//  Created by Philipp Tschauner on 11.08.22.
//

import Foundation
import SwiftUI
import Combine

class LanguageViewModel: GameProtocol {

    @Published var words: [WordPair] = []
    @Published var currentIndex: Int = 0
    @Published var randomIndex: Int = 0
    @Published var correctAttempts: Int = 0
    @Published var wrongAttempts: Int = 0
    @Published var timeRemaining: Int = 0
    @Published var animateText: Bool = false
    @Published var currentTextPosition: CGFloat = -300
    @Published var showGameAlert: Bool = false
    
    var languages: [GameConfiguration] = Language.allCases
    var timerCancellable: Cancellable?
    var config: GameConfiguration?
    var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
}

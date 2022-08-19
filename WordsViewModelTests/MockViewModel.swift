//
//  MockViewModel.swift
//  WordsViewModelTests
//
//  Created by Philipp Tschauner on 19.08.22.
//

import Foundation
import UIKit
import Combine
@testable import Words

class MockViewModel: GameProtocol {
    
    @Published var words: [WordPair] = []
    @Published var currentIndex: Int = 0
    @Published var randomIndex: Int = 0
    @Published var correctAttempts: Int = 0
    @Published var wrongAttempts: Int = 0
    @Published var timeRemaining: Int = 0
    @Published var animateText: Bool = false
    @Published var currentTextPosition: CGFloat = -300
    @Published var showGameAlert: Bool = false
    
    var timerCancellable: Cancellable?
    var config: GameConfiguration
    var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    
    required init(config: GameConfiguration) {
        self.config = config
        setup(withConfig: config)
    }
}

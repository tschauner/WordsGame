//
//  WordsViewModel.swift
//  Words
//
//  Created by Philipp Tschauner on 11.08.22.
//

import Foundation
import SwiftUI
import Combine

enum GameAlert {
    case start
    case end
}

class WordsViewModel: ObservableObject {
    
    @Published private(set) var words: [WordPair] = []
    @Published var currentIndex: Int = 0
    @Published var randomIndex: Int = 0
    @Published var correctAttempts: Int = 0
    @Published var wrongAttempts: Int = 0
    @Published var timeRemaining: Int = 5
    @Published var animateText: Bool = false
    @Published var currentTextPosition: CGFloat = -300
    @Published var alert: GameAlert?
    @Published var showGameAlert: Bool = false
    
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    var timer = Timer.publish(every: 1, on: .main, in: .common)
    private var timerCancellable: Cancellable?
    private(set) var config: GameConfiguration?
    
    var alertMessage: String {
        config?.alertMessage(isSuccess: isSuccess) ?? "OOPS\nSomething wen't wrong"
    }
    
    var isGameReady: Bool {
        !words.isEmpty
    }
    
    var currentOriginal: String? {
        guard currentIndex <= words.count - 1 else { return nil }
        return words[currentIndex].original
    }
    
    var currentRandomTranslation: String? {
        guard randomIndex <= words.count - 1 else { return nil }
        return words[randomIndex].translation
    }
    
    var shouldHideAnimation: Bool {
        animateText == false || shouldFinishGame
    }
    
    var shouldFinishGame: Bool {
        correctAttempts == config?.correctAttempts || wrongAttempts == config?.wrongAttempts
    }
    
    private var isSuccess: Bool {
        correctAttempts == config?.correctAttempts
    }
    
    func setup(withConfig config: GameConfiguration) {
        self.config = config
        setup()
    }
    
    // MARK: GAME ACTIONS
    
    private func setup() {
        loadWords()
        reset()
        diceIndex()
    }
    
    func reset() {
        wrongAttempts = 0
        correctAttempts = 0
        currentIndex = 0
        resetTimer()
        resetAnimation()
    }
    
    private func fail() {
        diceIndex()
        wrongAttempts += 1
        checkIfGameFinished()
    }
    
    func skip() {
        fail()
        animateText(false)
    }
    
    private func checkIfGameFinished() {
        if shouldFinishGame {
            stopTimer()
            showGameAlert = true
            setMinAnimationPosition()
        }
    }
    
    private func diceIndex() {
        randomIndex = randomInteger
        increaseIndex()
    }
    
    /// Ends the game immediately
    func quit() {
        exit(0)
    }
    
    /// Sets the game state for a selected choice
    /// - Parameter choice: either correct or wrong button selected
    func choiceSelected(_ choice: Choice) {
        resetAnimation()
        evaluate(choice)
        checkIfGameFinished()
        resetTimer()
        diceIndex()
    }
    
    // MARK: WORDS
    
    private func loadWords() {
        guard let words: [WordPair] = config?.model else {
            assertionFailure("config file \(String(describing: config?.fileName)) is not available")
            return
        }
        self.words = words
    }
    
    private var currentWord: WordPair? {
        guard currentIndex <= words.count - 1 else { return nil }
        return words[currentIndex]
    }
    
    private func increaseIndex() {
        if currentIndex == words.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
    }
    
    private func evaluate(_ choice: Choice) {
        if isCorrect(choice: choice) {
            correctAttempts += 1
        } else {
            wrongAttempts += 1
        }
    }
    
    /// Returns a random integer between currentIndex and currentIndex + 3 = 25%
    private var randomInteger: Int {
        guard currentIndex + 3 <= words.count - 1 else { return 0 }
        return Int.random(in: currentIndex...currentIndex + 3)
    }
    
    private func isCorrect(choice: Choice) -> Bool {
        switch choice {
        case .correct:
            return currentWord?.translation == currentRandomTranslation
        case .wrong:
            return currentWord?.translation != currentRandomTranslation
        }
    }
    
    // MARK: TIMER
    
    func setTimer() {
        guard !shouldFinishGame else { return }
        
        if timeRemaining == 5 {
            animateText = true
        }
        
        timeRemaining -= 1
        if timeRemaining == 0 {
            timeRemaining = 5
            animateText = false
            skip()
        }
    }
    
    private func stopTimer() {
        timerCancellable?.cancel()
        timer.connect().cancel()
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
        timerCancellable = timer.connect()
    }
    
    private func resetTimer() {
        timeRemaining = config?.maxTime ?? 5
        startTimer()
    }
    
    // MARK: ANIMATION

    func animateText(_ animate: Bool) {
        if animate {
            animateMaxPosition()
        } else {
            setMinAnimationPosition()
        }
    }
    
    private func animateMaxPosition() {
        DispatchQueue.main.async { [unowned self] in
            withAnimation(.linear(duration: Double(config?.maxTime ?? 5))) {
                self.setMaxAnimationPosition()
            }
        }
    }

    private func setMinAnimationPosition() {
        currentTextPosition = -screenHeight/2
    }
    
    private func setMaxAnimationPosition() {
        currentTextPosition = screenHeight/2
    }
    
    private func resetAnimation() {
        setMinAnimationPosition()
        animateMaxPosition()
    }
    
    // MARK: ALERT
    
    @ViewBuilder
    var gameAlert: some View {
        Button("Quit", role: .destructive) { [unowned self] in
            self.quit()
        }
        Button("\(isSuccess ? "Play" : "Try") again", role: .cancel) { [unowned self] in
            self.reset()
        }
    }
}

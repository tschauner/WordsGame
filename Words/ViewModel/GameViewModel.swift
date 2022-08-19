//
//  GameViewModel.swift
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

protocol GameProtocol: ObservableObject {
    var timerCancellable: Cancellable? { get set }
    var currentIndex: Int { get set }
    var randomIndex: Int { get set }
    var correctAttempts: Int { get set }
    var wrongAttempts: Int { get set }
    var timeRemaining: Int { get set }
    var words: [WordPair] { get set }
    var config: GameConfiguration? { get set }
    var currentTextPosition: CGFloat { get set }
    var showGameAlert: Bool { get set }
    var timer: Timer.TimerPublisher { get set }
    var animateText: Bool { get set }
}

extension GameProtocol {
    
    var alertMessage: String {
        config?.alertMessage(isSuccess: isSuccess) ?? "OOPS\nSomething wen't wrong"
    }
    
    var currentOriginal: String? {
        guard currentIndex <= words.count - 1 else { return nil }
        return words[currentIndex].original
    }
    
    var currentRandomTranslation: String? {
        guard randomIndex <= words.count - 1 else { return nil }
        return words[randomIndex].translation
    }
    
    var isGameReady: Bool {
        words.isEmpty == false
    }
    
    private var screenHeight: CGFloat { UIScreen.main.bounds.height }
    
    var shouldFinishGame: Bool {
        correctAttempts == config?.correctAttempts || wrongAttempts == config?.wrongAttempts
    }
    
    private var currentWord: WordPair? {
        guard currentIndex <= words.count - 1 else { return nil }
        return words[currentIndex]
    }
    
    private var isSuccess: Bool {
        correctAttempts == config?.correctAttempts
    }
    
    func loadWords() {
        guard let words: [WordPair] = config?.model else {
            assertionFailure("config file \(String(describing: config?.fileName)) is not available")
            return
        }
        self.words = words
    }
    
    func setMinAnimationPosition() {
        currentTextPosition = -screenHeight/2
    }
    
    private func setMaxAnimationPosition() {
        currentTextPosition = screenHeight/2
    }
    
    private func resetAnimation() {
        setMinAnimationPosition()
        animateMaxPosition()
    }
    
    func animateText(_ animate: Bool) {
        if animate {
            animateMaxPosition()
        } else {
            setMinAnimationPosition()
        }
    }
    
    private func evaluate(_ choice: Choice) {
        if isCorrect(choice: choice) {
            correctAttempts += 1
        } else {
            wrongAttempts += 1
        }
    }
    
    private func increaseIndex() {
        if currentIndex == words.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
    }
    
    /// Returns a random integer between currentIndex and currentIndex + 3 = 25%
    private var randomInteger: Int {
        guard currentIndex + 3 <= words.count - 1 else { return 0 }
        return Int.random(in: currentIndex...currentIndex + 3)
    }
    
    private func animateMaxPosition() {
        DispatchQueue.main.async { [unowned self] in
            withAnimation(.linear(duration: Double(config?.maxTime ?? 5))) {
                self.setMaxAnimationPosition()
            }
        }
    }
    
    private func isCorrect(choice: Choice) -> Bool {
        switch choice {
        case .correct:
            return currentWord?.translation == currentRandomTranslation
        case .wrong:
            return currentWord?.translation != currentRandomTranslation
        }
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
    
    func fail() {
        diceIndex()
        wrongAttempts += 1
        checkIfGameFinished()
    }
    
    func skip() {
        fail()
        animateText(false)
    }
    
    private func diceIndex() {
        randomIndex = randomInteger
        increaseIndex()
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
        timerCancellable = timer.connect()
    }
    
    private func stopTimer() {
        timerCancellable?.cancel()
        timer.connect().cancel()
    }
    
    private func resetTimer() {
        timeRemaining = config?.maxTime ?? 5
        startTimer()
    }
    
    private func checkIfGameFinished() {
        if shouldFinishGame {
            stopTimer()
            showGameAlert = true
            setMinAnimationPosition()
        }
    }
    
    func choiceSelected(_ choice: Choice) {
        resetAnimation()
        evaluate(choice)
        checkIfGameFinished()
        resetTimer()
        diceIndex()
    }
    
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
    
    func quit() {
        exit(0)
    }
    
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

class GameViewModel: GameProtocol {

    @Published var words: [WordPair] = []
    @Published var currentIndex: Int = 0
    @Published var randomIndex: Int = 0
    @Published var correctAttempts: Int = 0
    @Published var wrongAttempts: Int = 0
    @Published var timeRemaining: Int = 0
    @Published var animateText: Bool = false
    @Published var currentTextPosition: CGFloat = -300
    @Published var alert: GameAlert?
    @Published var showGameAlert: Bool = false
    
    var timerCancellable: Cancellable?
    var config: GameConfiguration?
    var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
}

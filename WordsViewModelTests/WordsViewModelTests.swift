//
//  GameViewModelTests.swift
//  GameViewModelTests
//
//  Created by Philipp Tschauner on 15.08.22.
//

import XCTest
@testable import Words

class GameViewModelTests: XCTestCase {
    
    var viewModel: GameViewModel!

    override func setUp() {
        viewModel = .init()
    }
    
    func testSetupWithConfigLoadWordsSuccessfulTrue() {
        let language = Language.en_es
        viewModel.setup(withConfig: language)
        
        XCTAssertTrue(viewModel.isGameReady)
    }
    
    func testWrongAttemptsIterateTrue() {
        let language = Language.en_es
        viewModel.setup(withConfig: language)
        
        viewModel.skip()
        XCTAssertTrue(viewModel.wrongAttempts == 1)
    }
    
    func testCorrectAttemptsIterateTrue() {
        let language = Language.en_es
        viewModel.setup(withConfig: language)
        
        viewModel.choiceSelected(.correct)
        let assert = viewModel.correctAttempts == 1 || viewModel.wrongAttempts == 1
        XCTAssertTrue(assert)
    }
    
    func testMaxWrongAttemptsIterateEndsFinishTrue() {
        let language = Language.en_es
        viewModel.setup(withConfig: language)
        
        for _ in (0..<language.wrongAttempts) {
            viewModel.skip()
        }

        XCTAssertTrue(viewModel.shouldFinishGame)
    }
    
    func testCorrectRatioTrue() {
        let language = Language.en_es
        viewModel.setup(withConfig: language)
        
        for _ in (0..<4) {
            viewModel.choiceSelected(.wrong)
        }

        XCTAssertTrue(viewModel.correctAttempts > 0)
    }
    
    func testMockGameConfigurationModelAvailableFail() {
        let config = MockGameConfiguration.dummy
        XCTAssertFalse(config.isAvailable)
    }
}

//
//  GameViewModelTests.swift
//  GameViewModelTests
//
//  Created by Philipp Tschauner on 15.08.22.
//

import XCTest
@testable import Words

class GameViewModelTests: XCTestCase {
    
    var viewModel: MockViewModel!

    override func setUp() {
        viewModel = .init(config: SpanishEN())
    }
    
    func testSetupWithConfigLoadWordsSuccessfulTrue() {
        XCTAssertTrue(viewModel.isGameReady)
    }
    
    func testWrongAttemptsIterateTrue() {
        viewModel.skip()
        XCTAssertTrue(viewModel.wrongAttempts == 1)
    }
    
    func testCorrectAttemptsIterateTrue() {
        viewModel.choiceSelected(.correct)
        let assert = viewModel.correctAttempts == 1 || viewModel.wrongAttempts == 1
        XCTAssertTrue(assert)
    }
    
    func testMaxWrongAttemptsIterateEndsFinishTrue() {
        let language = SpanishEN()
        for _ in (0..<language.wrongAttempts) {
            viewModel.skip()
        }

        XCTAssertTrue(viewModel.shouldFinishGame)
    }
    
    func testCorrectRatioTrue() {
        for _ in (0..<4) {
            viewModel.choiceSelected(.wrong)
        }

        XCTAssertTrue(viewModel.correctAttempts > 0)
    }
    
    func testMockGameConfigurationModelAvailableFail() {
        let config = MockGameConfiguration()
        XCTAssertFalse(config.getModel() != nil)
    }
}

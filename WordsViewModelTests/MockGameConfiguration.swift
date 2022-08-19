//
//  MockLanguage.swift
//  GameViewModelTests
//
//  Created by Philipp Tschauner on 15.08.22.
//


@testable import Words

enum MockGameConfiguration: GameConfiguration {
    case dummy
    
    var fileName: String { "dummy.json" }
    var description: String { "Dummy" }
    var model: [WordPair]? { nil }
    var isAvailable: Bool {
        model != nil
    }
    
}

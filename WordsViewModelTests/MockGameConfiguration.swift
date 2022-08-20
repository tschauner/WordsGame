//
//  MockLanguage.swift
//  GameViewModelTests
//
//  Created by Philipp Tschauner on 15.08.22.
//


@testable import Words

struct MockGameConfiguration: GameConfiguration {
    var fileName: String { "words.json" }
    var description: String { "Dummy" }
    var correctAttempts: Int { 1 }
    var wrongAttempts: Int { 100 }
    
    var model: [WordPair]? {
        let model: [EnEsModel]? = DummyData.load(fileName)
        return model
    }
}

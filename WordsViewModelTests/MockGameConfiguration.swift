//
//  MockLanguage.swift
//  GameViewModelTests
//
//  Created by Philipp Tschauner on 15.08.22.
//


@testable import Words

struct MockGameConfiguration: GameConfiguration {
    var fileName: String { "dummy.json" }
    var description: String { "Dummy" }
    
    func getModel() -> [WordPair]? {
        let model: [EnEsModel]? = DummyData.load(fileName)
        return model
    }
}

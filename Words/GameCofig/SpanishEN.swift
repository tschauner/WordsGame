//
//  SpanishEN.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import Foundation

struct SpanishEN: GameConfiguration {
    var fileName: String { "words.json" }
    var description: String { "EN-ES" }
    
    func getModel() -> [WordPair]? {
        let model: [EnEsModel]? = DummyData.load(fileName)
        return model
    }
}


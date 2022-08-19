//
//  Language.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import Foundation

enum Language: CaseIterable, GameConfiguration {
    
    case en_es
    
    var fileName: String {
        switch self {
        case .en_es:
            return "words.json"
        }
    }
    
    var description: String {
        switch self {
        case .en_es:
            return "EN-ES"
        }
    }
    
    var model: [WordPair]? {
        switch self {
        case .en_es:
            let model: [EnEsModel]? = DummyData.load(fileName)
            return model
        }
    }
    
    var isAvailable: Bool {
        switch self {
        case .en_es: return DummyData.available(fileName)
        }
    }
}


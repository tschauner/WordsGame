//
//  Language.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import Foundation

protocol GameConfiguration {
    var fileName: String { get }
    var description: String { get }
    var model: [WordPair]? { get }
    var maxTime: Int { get }
    var correctAttempts: Int { get }
    var wrongAttempts: Int { get }
    var isAvailable: Bool { get }
}

extension GameConfiguration {
    var maxTime: Int { 5 }
    var correctAttempts: Int { 15 }
    var wrongAttempts: Int { 3 }
    
    func alertMessage(isSuccess: Bool) -> String {
        let successMessage = "Congrats! 🎉\n\(correctAttempts) correct answers!"
        let failMessage = "Oh noo! 😵\n\(wrongAttempts) wrong attemps"
        return isSuccess ? successMessage : failMessage
    }
}

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


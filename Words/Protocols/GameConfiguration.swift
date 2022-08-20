//
//  GameConfiguration.swift
//  Words
//
//  Created by Philipp Tschauner on 19.08.22.
//

import Foundation

protocol GameConfiguration {
    var fileName: String { get }
    var description: String { get }
    var maxTime: Int { get }
    var correctAttempts: Int { get }
    var wrongAttempts: Int { get }
    var model: [WordPair]? { get }
}

extension GameConfiguration {
    var maxTime: Int { 5 }
    var correctAttempts: Int { 15 }
    var wrongAttempts: Int { 3 }
    
    func alertMessage(isSuccess: Bool) -> String {
        let successMessage = "Congrats! 🎉\n\(correctAttempts) correct answers!"
        let failMessage = "Oh noo! 😵\n\(wrongAttempts) wrong attempts"
        return isSuccess ? successMessage : failMessage
    }
}

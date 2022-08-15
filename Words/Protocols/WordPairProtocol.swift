//
//  WordPairProtocol.swift
//  Words
//
//  Created by Philipp Tschauner on 12.08.22.
//

import Foundation

protocol WordPair: Codable {
    var original: String { get }
    var translation: String { get }
}

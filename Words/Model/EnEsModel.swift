//
//  EnEsModel.swift
//  Words
//
//  Created by Philipp Tschauner on 11.08.22.
//

import Foundation

struct EnEsModel: Codable {
    let text_eng: String
    let text_spa: String
}

extension EnEsModel: WordPair {
    var original: String { text_eng }
    var translation: String { text_spa }
}

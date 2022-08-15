//
//  GameImage.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

enum GameImage: String {
    case close = "xmark"
    case retry = "gobackward"
}

extension SwiftUI.Image {
    
    init(name: GameImage) {
        self.init(systemName: name.rawValue)
    }
}

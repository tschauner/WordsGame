//
//  Extension+Font.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

extension SwiftUI.Font {
    
    static func blackRounded(size: CGFloat = 24) -> Font {
        .system(size: size, weight: .black, design: .rounded)
    }
}

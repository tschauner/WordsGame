//
//  GameSection.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import Foundation

enum GameSection: CaseIterable {
    case navigation
    case stats
    case canvas
    case controls
    
    func isVisible(viewModel: AnyObject) -> Bool {
        guard let viewModel = viewModel as? GameViewModel else { return false }
        
        switch self {
        case .navigation, .stats, .controls:
            return viewModel.isGameReady
        default:
            return true
        }
    }
}

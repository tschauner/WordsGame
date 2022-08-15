//
//  GameNavigationView.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

struct GameNavigationView: View {
    
    @EnvironmentObject var viewModel: WordsViewModel
    
    var body: some View {
        HStack {
            Image(name: .close)
                .font(.blackRounded())
                .foregroundColor(.black)
                .button(action: viewModel.quit)
            
            Spacer()
            
            Image(name: .retry)
                .font(.blackRounded())
                .foregroundColor(.black)
                .button(action: viewModel.reset)
        }
        .frame(height: 40)
    }
}

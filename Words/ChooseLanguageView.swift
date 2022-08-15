//
//  ChooseLanguageView.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

struct ChooseLanguageView: View {
    
    var languages: [GameConfiguration] = Language.allCases
    let action: (GameConfiguration) -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            ForEach(languages, id: \.description) { language in
                Text(language.description)
                    .frame(height: 40)
                    .font(.blackRounded(size: 20))
                    .button {
                        action(language)
                    }
            }
        }
    }
}

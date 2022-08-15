//
//  AlertView.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

struct AlertView<Content: View>: View {
    
    let content: () -> Content
    var title: String?
    
    init(@ViewBuilder content: @escaping () -> Content, title: String?) {
        self.content = content
        self.title = title
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if let title = title {
                Text(title)
                    .font(.blackRounded(size: 20))
                    .multilineTextAlignment(.center)
            }
            
            content()
        }
        .padding(20)
        .background(
            Color.white
                .cornerRadius(6)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 0)
        )
    }
}

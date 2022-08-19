//
//  ControlsView.swift
//  Words
//
//  Created by Philipp Tschauner on 11.08.22.
//

import SwiftUI

enum Choice: String, CaseIterable {
    case correct
    case wrong
    
    var title: String {
        "\(rawValue.uppercased()) \(self == .correct ? "👍" : "👎")"
    }
}

struct ChoiceButton: View {
    
    let choice: Choice
    let action: () -> Void
    var cornerRadius: CGFloat = 6
    
    @State var isDragging: Bool = false
    
    var body: some View {
        Text(choice.title)
            .font(.blackRounded(size: 20))
            .frame(height: 60)
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(cornerRadius)
            .addBorder(Color.black.opacity(isDragging ? 0.1 : 0), cornerRadius: cornerRadius)
            .shadow(color: Color.black.opacity(isDragging ? 0 : 0.2), radius: isDragging ? 0 : 3, x: 0, y: 0)
            .gesture(
                DragGesture(minimumDistance: 0.0)
                    .onChanged { _  in
                        withAnimation(.linear(duration: 0.1)) {
                            isDragging = true
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.linear(duration: 0.1)) {
                            isDragging = false
                        }
                        action()
                    }
            )
    }
}

struct GameControlsView: View {
    
    var choiceSelected: (Choice) -> Void
    
    var body: some View {
        HStack {
            ForEach(Choice.allCases, id: \.self) { choice in
                ChoiceButton(choice: choice) {
                    choiceSelected(choice)
                }
            }
        }
    }
}

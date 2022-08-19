//
//  TimerView.swift
//  Words
//
//  Created by Philipp Tschauner on 14.08.22.
//

import SwiftUI

struct TimerView<T: GameProtocol>: View {
    
    @EnvironmentObject var viewModel: T
    
    @State var animate: Bool = false
    
    var body: some View {
        Text("⏱ \(viewModel.timeRemaining)")
            .font(.blackRounded(size: 26))
            .multilineTextAlignment(.center)
            .scaleEffect(animate ? 1.2 : 1)
            .animation(.spring(), value: animate)
            .onReceive(viewModel.timer) { _ in
                viewModel.setTimer()
//                animate = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                    animate = false
//                }
            }
        
    }
}

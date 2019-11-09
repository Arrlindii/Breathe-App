//
//  ContentTestView.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 02.11.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import Foundation
import SwiftUI

//TODO: Refactor
struct ExcerciseAnimationView: View {
    @State var isAnimating = false
    @State var shown = false
    
    var animationDuration: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                //Background View
                if self.shown {
                    Rectangle().background(Color.black)
                        .transition(.opacity)
                    
                    FlowerAnimatableView(sides: 6,
                                         size: geometry.size.height*0.3,
                                         scale: self.isAnimating ? 0.05: 1.0)
                        .transition(AnyTransition.scale(scale: 0.65)
                            .combined(with: .opacity)
                            .combined(with: .offset(y: -120))
                        )
                }
            }
        }.onAppear(perform: {
            withAnimation(.easeInOut(duration: self.animationDuration)) {
                self.shown = true
            }
            //TODO: Move this to animatable view, with a state var to state start animation
            withAnimation(Animation.easeIn(duration: 1.5).repeatForever(autoreverses: true).delay(self.animationDuration)) {
                self.isAnimating = true
            }
        })
    }
}

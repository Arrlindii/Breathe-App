//
//  ContentTestView.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 02.11.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import Foundation
import SwiftUI

struct ExcerciseAnimationView: View {
    @State var largeFlower = true
    @State var shown = false
    
    var animationDuration: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if self.shown {
                    Rectangle().background(Color.black)
                        .transition(.opacity)
                    
                    FlowerAnimatableView(sides: 6,
                                         size: geometry.size.height*0.3,
                                         scale: self.largeFlower ? 1.0 : 0.05)
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
            withAnimation(Animation.easeIn(duration: 1.5).repeatForever().delay(self.animationDuration)) {
                self.largeFlower.toggle()
            }
        })
    }
}

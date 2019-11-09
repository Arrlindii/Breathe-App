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
    @State var presented: Bool = false
    @State var isAnimating = false
    @State var isOffseted = true
    
    var animationDuration: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                //Background View
                Rectangle().background(Color.black)
                    .opacity(self.presented ? 1.0 : 0.0)
                
                //Flower View
                FlowerAnimatableView(sides: 6,
                                     size: self.presented ? geometry.size.height*0.3 : geometry.size.height*0.175,
                                     scale: self.isAnimating ? 0.05: 1.0)
                    .opacity(self.presented ? 1.0 : 0.0)
                    .offset(x: 0, y: !self.presented ? -115 : 0) //TODO: Change this, only for testing
                    .onAppear(perform: {
                        withAnimation(Animation.easeIn(duration: self.animationDuration)) {self.presented.toggle()}
                        
                        withAnimation(Animation.easeIn(duration: 1.5).repeatForever(autoreverses: true).delay(self.animationDuration)) {
                            self.isAnimating = true
                        }
                    })
            }
        }
    }
}

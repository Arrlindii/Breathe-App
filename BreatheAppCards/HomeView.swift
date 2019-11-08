//
//  HomeView.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 20.10.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State var percentage: Double = 0.65

    var body: some View {
             GeometryReader { geometry in
                    VStack(alignment: .center, spacing: 5){
                        DaysView().background(Color.darkGrayColor)
                            .frame(height: 100)
                        
                        Spacer()
                        (Text("Today, ").font(.bodyText).bold() + Text(Date().dateString).font(.bodyText)).foregroundColor(Color.white)
                        Spacer()
                        HStack(alignment: .center, spacing: 25) {
                            Spacer()
                            RingView(percentage: self.percentage, ringWidth: 35.0, backgroundColor: Color.darkGrayColor)
                                .animation(Animation.easeInOut(duration: 1.0))
                                .overlay(DailyGoalView())
                           Spacer()
                        }.frame(maxHeight: geometry.size.width)
                        Spacer()
                        Text("Swipe up to select exercise").font(.bodyText).foregroundColor(Color.white)
                        Spacer()
                    }
                }
        }
   
}

struct DailyGoalView: View {
    var body: some View {
        (Text("10min ").bold() + Text("daily goal"))
            .font(.bodyText)
            .foregroundColor(Color.white)
    }
}

struct ContentView : View {
    //TODO: Save cardStack in enviorment
    @ObservedObject var cardStack = CardStack(numberOfCards: Exercise.allExercises.count)
    @State var isDetailsPresented: Bool = false
    //TODO: Save animation Duration as an enviorment object
    let animationDuration = 0.8
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        // For navigation bar background color
        UINavigationBar.appearance().backgroundColor = .green
    }
    
    var body: some View {
        ZStack {
            HomeView()
            
            //Card Stack view
            Rectangle().background(Color.black)
                .animation(.easeIn(duration: 0.4))
                .opacity(Double(cardStack.presentationPercentage))
            GeometryReader { geometry in
                CardStackView(cardStack: self.cardStack,
                              width: geometry.size.width,
                              height: geometry.size.height,
                              fullSizeCard: self.$isDetailsPresented,
                              animationDuration: self.animationDuration
                    )
                {
                    
                    //                    self.isDetailsPresented = true
                    withAnimation(Animation.easeIn(duration: self.animationDuration*0.5)) {self.isDetailsPresented = true}
                    
                }
                .opacity(self.isDetailsPresented ? 0.0 : 1.0)
            }
            
            if isDetailsPresented {
                ExcerciseAnimationView(animationDuration: self.animationDuration).onTapGesture {
                    self.isDetailsPresented = false
                }
            }
        }.background(Color.black)
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView().background(Color.black)
    }
}
#endif




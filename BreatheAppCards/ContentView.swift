//
//  ContentView.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 30.09.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//
import SwiftUI

struct ContentView : View {
    @ObservedObject var cardStack = CardStack(numberOfCards: Exercise.allExercises.count) //TODO: Save cardStack in enviorment
    @State var isDetailsPresented: Bool = false
    @State var isExcerciseCompletedPresented: Bool = false
    @State var excerciseCompleted: Bool = false
    
    let animationDuration = 0.8
    
    
    var body: some View {
        ZStack {
            HomeView()
            
            ExerciseBackgroundView()
                .opacity(Double(cardStack.presentationPercentage))
            
            CardStackView(cardStack: self.cardStack,
                          fullSizeCard: self.$isDetailsPresented,
                          animationDuration: self.animationDuration
            )
            
            if isDetailsPresented {
                ExcerciseAnimationView(animationDuration: self.animationDuration*2).onTapGesture {
                    self.isExcerciseCompletedPresented = true
                }
            }
            
            if isExcerciseCompletedPresented {
                ExcerciseCompletedView().onTapGesture {
                    self.isDetailsPresented = false
                    self.isExcerciseCompletedPresented = false
                }
            }
            
        }.background(Color.black).edgesIgnoringSafeArea([.bottom])
    }
    
}

struct DailyGoalView: View {
    var body: some View {
        (Text("10min ").bold() + Text("daily goal"))
            .font(.bodyText)
            .foregroundColor(Color.white)
    }
}


struct ExerciseBackgroundView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea([.top, .bottom])
            VStack {
                
                (Text("Select ")
                    .font(.bodyText).bold() +
                    Text("breathe exercise")
                        .font(.bodyText))
                    .foregroundColor(Color.white)
                    .offset(y: 25)
                Spacer()
            }
        }
    }
}

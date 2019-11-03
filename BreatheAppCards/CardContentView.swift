//
//  CardContentView.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 16.10.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import SwiftUI

struct CardContentView: View {
    @State private var sides: Double = 6
    @State var fullScale = true
    let exercise: Exercise
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                Color.clear.frame(width: geometry.size.height*0.3, height: geometry.size.height*0.3)
                    .overlay(Color.clear.modifier(FlowerAnimatableView(sides: self.sides, size: geometry.size.height*0.3, scale: self.fullScale ? 1.0 : 0.05)))
                Text(self.exercise.title)
                    .font(.headerText)
                    .bold()
                    .foregroundColor(Color.white)
                    
                Text("Last time: \(self.exercise.length) min")
                    .font(.detailText)
                    .foregroundColor(Color.textGray)

                Text(self.exercise.description)
                    .padding(.horizontal, 30)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .font(.bodyText)
                    .foregroundColor(Color.lightTextGray)
                Spacer().frame(height: 10)
                CounterView(minValue: 1, maxValue: self.exercise.length) { count in
                    withAnimation(Animation.easeOut(duration: 0.5)) {
                        self.sides = Double(count) + 5
                    }
                }
                Spacer()
            }.onTapGesture {
                withAnimation(Animation.easeIn(duration: 1.5).repeatForever(autoreverses: true)) {
                    self.fullScale = false
                }
            }
        }
    }
}


struct CounterView: View {
    @State var count: Int = 1
    var minValue: Int
    var maxValue: Int
    var action: ((Int) -> Void)
    
    var body: some View {
        HStack() {
            Button(action: {
                self.count = max(self.count - 1, self.minValue)
                self.action(self.count)
            }, label: {
                Image("minus")
            })
                .padding(.horizontal, 15)
            
            Text("\(count)")
                .font(.largeBodyText)
                .bold()
                .foregroundColor(Color.white)
                +
            Text(" min")
                .font(.largeBodyText)
                .foregroundColor(Color.white)
            
            Button(action: {
                self.count = min(self.count + 1, self.maxValue)
                self.action(self.count)
            }, label: {
                Image("plus")
            })
                .padding(.horizontal, 15)
        }
    }
}


#if DEBUG
struct CardContentView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                Rectangle().background(Color.black)
                GeometryReader { geometry in
                    CardContentView(exercise: Exercise.allExercises.first!).background(Color.darkGrayColor)
                        .frame(width: geometry.size.width*0.8, height: geometry.size.height*0.65, alignment: .center)
                }
                 
              }.previewDevice(PreviewDevice(rawValue: "iPhone X"))
                            .previewDisplayName("iPhone X Geometry Reader")
            
            ZStack {
                       Rectangle().background(Color.black)
                       CardContentView(exercise: Exercise.allExercises.first!).background(Color.darkGrayColor).frame(width: 320, height: 450)
            }.previewDevice(PreviewDevice(rawValue: "iPhone X"))
            .previewDisplayName("iPhone X")
        }
    }
}
#endif

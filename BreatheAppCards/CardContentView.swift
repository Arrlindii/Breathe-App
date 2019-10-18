//
//  CardContentView.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 16.10.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import SwiftUI

struct CardContentView: View {
    let exercise: Exercise
    
    init(exercise: Exercise) {
        self.exercise = exercise
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Spacer()
            Image("placeholder1")
                .resizable()
                .frame(width: 150, height: 150)
            Text(exercise.title)
                .font(.headerText)
                .bold()
                .foregroundColor(Color.white)
                
            Text("Last time: \(exercise.length) min")
                .font(.detailText)
                .foregroundColor(Color.textGray)

            Text(exercise.description)
                .padding(.horizontal, 30)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .font(.bodyText)
                .foregroundColor(Color.lightTextGray)
            Spacer().frame(height: 10)
            CounterView(min: 0, max: exercise.length)
            Spacer()
        }
    }
}


struct CounterView: View {
    @State var count: Int = 0
    private var minValue: Int
    private var maxValue: Int
    
    init(min: Int, max: Int) {
        self.minValue = min
        self.maxValue = max
    }
    
    var body: some View {
        HStack() {
            Button(action: {
                self.count = max(self.count - 1, self.minValue)
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
        ZStack {
            Rectangle().background(Color.black)
            CardContentView(exercise: Exercise.allExercises.first!).background(Color.cardGray).frame(width: 320, height: 450)
        }
    }
}
#endif

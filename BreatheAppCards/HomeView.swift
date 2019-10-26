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
    @State var percentage: Double = 0.1

    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                withAnimation {self.percentage = 1.0}
             }) {
                 Text("Increase Button")
             }
            Button(action: {
                withAnimation {self.percentage = 0.1}
                     }) {
                         Text("Reset Button")
                     }
            DaysView()
                .frame(height: 100)
            RingView(percentage: percentage, ringWidth: 50.0)
                .animation(Animation.easeInOut(duration: 1.0))
            Spacer()
        }
    }
}

struct DaysView: View {
    var days = ["M", "T", "W","T", "F", "S", "S"]
    
    var body: some View {
        HStack {
            ForEach(days, id: \.self) { day in
                DayView(dayAbv: day)
            }
        }
    }
}

struct DayView: View {
    var dayAbv: String
    
    var body: some View {
        VStack {
            Text("\(dayAbv)")
            RingView(percentage: Double.random(in: 0...1), ringWidth: 10.0)
        }
    }
}


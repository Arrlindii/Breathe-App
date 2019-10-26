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
                withAnimation {self.percentage = 0.9}
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
            BackgroundCircle()
                .animation(Animation.easeInOut(duration: 1.0))
                .overlay(RingView(percentage: percentage), alignment: .center)
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
            BackgroundCircle()
                .overlay(RingView(percentage: Double.random(in: 0...1)), alignment: .center)
        }
    }
}


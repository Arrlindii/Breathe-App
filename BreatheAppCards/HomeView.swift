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
    @Binding var percentage: Double
    @Binding var dailyGoalAchieved: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                HStack{
                    Text(Date().monthString)
                      .font(.largeTitle)
                      .bold()
                      .foregroundColor(Color.white)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                      .offset(x: 25)
                }
                .background(Color.darkGrayColor)
                
                DaysView().background(Color.darkGrayColor)
                    .frame(height: 100)
                
                Spacer().frame(height: 40)
                (Text("Today, ").font(.bodyText).bold() + Text(Date().dateString).font(.bodyText)).foregroundColor(Color.white)
                Spacer().frame(height: 35)
                HStack(alignment: .center, spacing: 25) {
                    Spacer()
                    RingView(percentage: self.percentage, ringWidth: 35.0, backgroundColor: Color.darkGrayColor)
                        .animation(Animation.easeInOut(duration: 1.0))
                        .overlay(DailyGoalView(dailyGoalAchieved: self.$dailyGoalAchieved))
                    Spacer()
                }.frame(maxHeight: geometry.size.width)
                Spacer().frame(height: 10)
                Text("Swipe up to select exercise").font(.bodyText).foregroundColor(Color.white)
                Spacer()
            }
        }
    }
    
}


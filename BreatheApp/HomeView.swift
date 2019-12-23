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
                Spacer()
                    .frame(width: geometry.size.width, height: 20)
                    .background(Color.darkGrayColor)
                
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
                
                Spacer()
                
                (Text("Today, ").font(.bodyText).bold() + Text(Date().dateString).font(.bodyText)).foregroundColor(Color.white)
                
                Spacer()
                
                RingView(percentage: self.percentage, ringWidth: 35.0, backgroundColor: Color.darkGrayColor)
                    .animation(Animation.easeInOut(duration: 1.0))
                    .overlay(DailyGoalView(dailyGoalAchieved: self.$dailyGoalAchieved))
                    .padding(.horizontal, geometry.size.width*0.1)
                    .frame(maxHeight: geometry.size.width - geometry.size.width*0.2)
                
                Spacer()
                
                Text("Swipe up to select exercise").font(.bodyText).foregroundColor(Color.white)
                
                Spacer()
                    .frame(width: geometry.size.width, height: 140)
            }
        }
    }
    
}


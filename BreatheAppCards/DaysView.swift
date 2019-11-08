//
//  DaysView.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 27.10.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import Foundation
import SwiftUI

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
    var ringBgColor = Color.grayGreenColor
    
    var body: some View {
        VStack(alignment: .center, spacing: 8){
            Spacer()
            Text("\(dayAbv)").font(.detailText).foregroundColor(Color.white)
            RingView(percentage: Double.random(in: 0...0.9), ringWidth: 4.0, backgroundColor: ringBgColor)
            .frame(maxHeight: 35.0)
            Spacer()
        }
    }
}

#if DEBUG
struct DayView_Previews : PreviewProvider {
    static var previews: some View {
        DaysView().background(Color.darkGrayColor)
    }
}
#endif

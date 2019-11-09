//
//  ExcerciseCompletedView.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 09.11.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import SwiftUI

struct ExcerciseCompletedView: View {
    var body: some View {
        Color.black.overlay(
            VStack {
                Spacer(minLength: 250)
                CenterView()
                Spacer()
                Button(action: {}, label: {
                    Text("Complete")
                        .bold()
                        .foregroundColor(Color.white)
                })
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.customGreenColor)
                    .cornerRadius(8)
                
                
                Spacer(minLength: 150)
            }
            .background(Color.black)
            .padding(.horizontal, 40)
        ).edgesIgnoringSafeArea([.top, .bottom])
    }
}

fileprivate struct CenterView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image("placeholder1")
            Text("Well done.")
                .font(.headerText)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
            (Text("Your 2 minute breathe excercise is done. So far you today you breathe")
                + Text("\n10 minutes ").bold().foregroundColor(Color.white) + Text("mindfully."))
                .multilineTextAlignment(.leading)
                .font(.bodyText)
                .foregroundColor(Color.lightTextGray)
        }
    }
}

struct ExcerciseCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        ExcerciseCompletedView()
        //            .background(Color.black)
    }
}

//
//  ExcerciseCompletedView.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 09.11.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import SwiftUI

struct ExcerciseCompletedView: View {
    @State var shown: Bool = false
    private let animationTime = 0.8
    var action: (() -> Void)?
    
    var body: some View {
        Color.black.overlay(
            VStack(alignment: .leading) {
                if shown {
                    FlowerAnimatableView(sides: 6,size: 65,scale: 1.0)
                        .frame(width: 65, height: 65)
                        .transition(AnyTransition.scale(scale: 0.3)
                            .combined(with: .offset(x: 100, y: 200)))
                        .animation(Animation.easeInOut(duration: animationTime))
                    
                    LabelView()
                        .animation(Animation.easeInOut(duration: animationTime).delay(animationTime/2))
                        .transition(AnyTransition.opacity.combined(with: .offset(x: 0, y: 80)))
                    Spacer().frame(height: 170)

                    Button(action: { self.action?() }, label: {return ButtonView()})
                        .animation(Animation.easeInOut(duration: animationTime).delay(animationTime/1.5))
                        .transition(AnyTransition.opacity.combined(with: .offset(x: 0, y: 80)))
                }
            }
            .background(Color.black)
            .padding(.horizontal, 40)
        ).edgesIgnoringSafeArea([.top, .bottom])
            .onAppear(perform: {
                self.shown = true
            })
    }
    
    public func onAction(action: @escaping () -> Void) -> ExcerciseCompletedView {
        var view = self
        view.action = action
        return view
    }
    
}


fileprivate struct ButtonView: View {
    var body: some View {
        Text("Complete")
            .bold()
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity, minHeight: 55)
            .background(Color.customGreenColor)
            .cornerRadius(8)
    }
}

fileprivate struct LabelView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Well done.")
                .font(.headerText)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
            (Text("Your 2 minute breathe excercise is done. So far today you breathe")
                + Text("\n10 minutes ").bold().foregroundColor(Color.white) + Text("mindfully."))
                .multilineTextAlignment(.leading)
                .font(.bodyText)
                .foregroundColor(Color.lightTextGray)
        }
    }
}


#if DEBUG
struct ExcerciseCompletedView_Previews : PreviewProvider {
    static var previews: some View {
        Color.black.overlay(
            ExcerciseCompletedView()
        )
    }
}
#endif
